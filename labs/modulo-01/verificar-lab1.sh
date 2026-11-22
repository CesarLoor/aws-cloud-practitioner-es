#!/usr/bin/env bash
# Laboratorio 1 · Pruebas de verificación. Solo consulta: no crea ni borra nada.
# Uso en AWS CloudShell:
#   curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-01/verificar-lab1.sh | bash
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
  *:root) bad "Estás usando el usuario raíz ($arn). Entra con tu usuario administrador." ;;
  *) pass "Identidad: $arn" ;;
esac

for region in us-east-1 sa-east-1; do
  n=$(aws ec2 describe-availability-zones --region "$region" \
    --filters Name=state,Values=available Name=zone-type,Values=availability-zone \
    --query "length(AvailabilityZones)" --output text 2>/dev/null)
  if [[ "$n" =~ ^[0-9]+$ ]] && [ "$n" -ge 3 ]; then
    pass "$region tiene $n zonas de disponibilidad (mínimo 3)"
  else
    bad "$region: se esperaban al menos 3 zonas de disponibilidad y se obtuvo '${n:-error}'"
  fi
done

pending=$(aws ec2 describe-regions --all-regions \
  --query "length(Regions[?OptInStatus=='not-opted-in'])" --output text 2>/dev/null)
echo "ℹ️  Regiones que requieren activación (not-opted-in): ${pending:-?}"

read -r mfa keys < <(aws iam get-account-summary \
  --query "SummaryMap.[AccountMFAEnabled,AccountAccessKeysPresent]" --output text 2>/dev/null)
if [ "${mfa:-}" = "1" ]; then pass "El usuario raíz tiene MFA"; else bad "El usuario raíz no tiene MFA (o tu usuario no puede consultar IAM)"; fi
if [ "${keys:-}" = "0" ]; then pass "El usuario raíz no tiene claves de acceso"; else bad "El usuario raíz tiene claves de acceso: elimínalas desde Credenciales de seguridad"; fi

echo
echo "Resultado: $ok pruebas correctas, $fail con problemas."
[ "$fail" -eq 0 ]
