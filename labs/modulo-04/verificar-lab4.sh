#!/usr/bin/env bash
# Laboratorio 4 · Pruebas de verificación. Solo consulta: no crea ni borra nada.
# Uso en AWS CloudShell:
#   curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-04/verificar-lab4.sh | bash
set -u
ok=0
fail=0
pass() { echo "✅ $1"; ok=$((ok + 1)); }
bad() { echo "❌ $1"; fail=$((fail + 1)); }

for region in us-east-1 sa-east-1; do
  status=$(aws cloudformation describe-stacks --stack-name lab-iac --region "$region" \
    --query "Stacks[0].StackStatus" --output text 2>/dev/null)
  case "$status" in
    CREATE_COMPLETE | UPDATE_COMPLETE) pass "Pila lab-iac en $region: $status" ;;
    "") bad "No existe la pila lab-iac en $region" ;;
    *) bad "Pila lab-iac en $region en estado $status (revisa la pestaña Eventos)" ;;
  esac
done

bucket=$(aws cloudformation describe-stacks --stack-name lab-iac --region us-east-1 \
  --query "Stacks[0].Outputs[?OutputKey=='NombreDelBucket'].OutputValue" --output text 2>/dev/null)
if [ -n "$bucket" ] && [ "$bucket" != "None" ]; then
  versioning=$(aws s3api get-bucket-versioning --bucket "$bucket" --query Status --output text 2>/dev/null)
  if [ "$versioning" = "Enabled" ]; then pass "El bucket $bucket tiene el versionado activado"; else bad "El bucket $bucket no tiene versionado"; fi
  if aws s3api get-bucket-tagging --bucket "$bucket" --query "TagSet[?Key=='Curso'].Value" --output text 2>/dev/null | grep -q "CLF-C02"; then
    pass "La actualización agregó la etiqueta Curso = CLF-C02"
  else
    bad "Falta la etiqueta Curso = CLF-C02 (paso 4: actualizar la pila)"
  fi
fi

drift=$(aws cloudformation describe-stack-resource-drifts --stack-name lab-iac --region us-east-1 \
  --query "StackResourceDrifts[?LogicalResourceId=='BucketLab'].StackResourceDriftStatus | [0]" --output text 2>/dev/null)
echo "ℹ️  Última detección de desviaciones de BucketLab: ${drift:-sin datos} (después del cambio manual debe decir MODIFIED)"

echo
echo "Resultado: $ok pruebas correctas, $fail con problemas."
[ "$fail" -eq 0 ]
