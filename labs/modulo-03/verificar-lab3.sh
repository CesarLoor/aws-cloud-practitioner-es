#!/usr/bin/env bash
# Laboratorio 3 · Pruebas de verificación. Solo consulta: no crea ni borra nada.
# Uso en AWS CloudShell (región us-east-1):
#   curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-03/verificar-lab3.sh | bash
set -u
ok=0
fail=0
pass() { echo "✅ $1"; ok=$((ok + 1)); }
bad() { echo "❌ $1"; fail=$((fail + 1)); }

runtime=$(aws lambda get-function-configuration --function-name lab-saludo \
  --query "[Runtime,Timeout,MemorySize]" --output text 2>/dev/null)
if [ -n "$runtime" ]; then
  pass "Existe la función lab-saludo (runtime, tiempo de espera y memoria: $runtime)"
else
  bad "No existe la función lab-saludo en esta región"
fi

if aws lambda get-policy --function-name lab-saludo --query Policy --output text 2>/dev/null | grep -q "s3.amazonaws.com"; then
  pass "La función tiene un desencadenador de Amazon S3"
else
  bad "La función no tiene permiso para que S3 la invoque (Parte B: agrega el desencadenador)"
fi

streams=$(aws logs describe-log-streams --log-group-name /aws/lambda/lab-saludo \
  --query "length(logStreams)" --output text 2>/dev/null)
if [[ "${streams:-}" =~ ^[0-9]+$ ]] && [ "$streams" -gt 0 ]; then
  pass "Hay registros de ejecución en CloudWatch Logs ($streams flujos)"
else
  bad "No hay registros en /aws/lambda/lab-saludo: ejecuta la función al menos una vez"
fi

envs=$(aws elasticbeanstalk describe-environments \
  --query "Environments[?Status!='Terminated'].[EnvironmentName,Health]" --output text 2>/dev/null)
echo "ℹ️  Parte C (opcional) · entornos de Elastic Beanstalk activos: ${envs:-ninguno}"

echo
echo "Resultado: $ok pruebas correctas, $fail con problemas."
[ "$fail" -eq 0 ]
