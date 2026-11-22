#!/usr/bin/env bash
# Entorno · Verifica la configuración base de la cuenta. Solo consulta: no crea ni borra nada.
# Uso en AWS CloudShell:
#   curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/comunes/verificar-configuracion.sh | bash
set -u
ok=0
fail=0
pass() { echo "✅ $1"; ok=$((ok + 1)); }
bad() { echo "❌ $1"; fail=$((fail + 1)); }

arn=$(aws sts get-caller-identity --query Arn --output text 2>/dev/null) || {
  echo "❌ No se pudo usar la AWS CLI. Ejecuta este script en AWS CloudShell."
  exit 1
}
case "$arn" in
  *:root) bad "Estás usando el usuario raíz. Entra con tu usuario administrador." ;;
  *) pass "Trabajas con un usuario de IAM: $arn" ;;
esac

read -r mfa keys < <(aws iam get-account-summary \
  --query "SummaryMap.[AccountMFAEnabled,AccountAccessKeysPresent]" --output text 2>/dev/null)
if [ "${mfa:-}" = "1" ]; then pass "El usuario raíz tiene MFA"; else bad "El usuario raíz no tiene MFA (paso 1)"; fi
if [ "${keys:-}" = "0" ]; then pass "El usuario raíz no tiene claves de acceso"; else bad "El usuario raíz tiene claves de acceso: elimínalas (paso 1)"; fi

account=$(aws sts get-caller-identity --query Account --output text)
budgets=$(aws budgets describe-budgets --account-id "$account" \
  --query "Budgets[].BudgetName" --output text 2>/dev/null)
if [ -n "$budgets" ] && [ "$budgets" != "None" ]; then
  pass "Presupuestos configurados: $budgets"
else
  bad "No hay presupuestos de AWS Budgets (paso 4)"
fi

if aws --version 2>&1 | grep -q "aws-cli/2\."; then pass "AWS CLI versión 2"; else bad "La AWS CLI no es la versión 2"; fi
echo "ℹ️  Región de trabajo: ${AWS_REGION:-${AWS_DEFAULT_REGION:-sin definir}} (se recomienda us-east-1)"

echo
echo "Resultado: $ok pruebas correctas, $fail con problemas."
[ "$fail" -eq 0 ]
