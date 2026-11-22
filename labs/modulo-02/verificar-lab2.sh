#!/usr/bin/env bash
# Laboratorio 2 · Pruebas de verificación. Solo consulta: no crea ni borra nada.
# Uso en AWS CloudShell (región us-east-1):
#   curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-02/verificar-lab2.sh | bash
set -u
ok=0
fail=0
pass() { echo "✅ $1"; ok=$((ok + 1)); }
bad() { echo "❌ $1"; fail=$((fail + 1)); }

ips=$(aws ec2 describe-instances \
  --filters "Name=tag:Proyecto,Values=lab-clf" "Name=instance-state-name,Values=running" \
  --query "Reservations[].Instances[].PublicIpAddress" --output text 2>/dev/null) || {
  echo "❌ No se pudo usar la AWS CLI. Ejecuta este script en AWS CloudShell."
  exit 1
}
if [ -n "$ips" ] && [ "$ips" != "None" ]; then
  pass "Instancias del laboratorio en ejecución con IP pública: $ips"
  for ip in $ips; do
    if curl -s --max-time 5 "http://$ip" | grep -q "Hola desde"; then
      pass "El servidor web de $ip responde"
    else
      bad "El servidor web de $ip no responde por HTTP (revisa la regla del puerto 80 y espera 1-2 minutos)"
    fi
  done
else
  bad "No hay instancias en ejecución con la etiqueta Proyecto=lab-clf e IP pública"
fi

http=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=lab-web-sg" \
  --query "SecurityGroups[0].IpPermissions[?FromPort==\`80\`].IpRanges[].CidrIp" --output text 2>/dev/null)
ssh_open=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=lab-web-sg" \
  --query "SecurityGroups[0].IpPermissions[?FromPort==\`22\`].IpRanges[].CidrIp" --output text 2>/dev/null)
if [[ "$http" == *"0.0.0.0/0"* ]]; then pass "lab-web-sg permite HTTP (80) desde internet"; else bad "lab-web-sg no permite HTTP (80) desde 0.0.0.0/0"; fi
if [ -z "$ssh_open" ]; then
  bad "lab-web-sg no tiene regla SSH (22)"
elif [[ "$ssh_open" == *"0.0.0.0/0"* ]]; then
  bad "SSH (22) está abierto a todo internet: limítalo a tu IP"
else
  pass "SSH (22) limitado a: $ssh_open"
fi

if aws sqs get-queue-url --queue-name lab-pedidos >/dev/null 2>&1; then pass "Existe la cola de SQS lab-pedidos"; else bad "No existe la cola de SQS lab-pedidos"; fi

topic=$(aws sns list-topics --query "Topics[?ends_with(TopicArn, ':lab-alertas')].TopicArn" --output text 2>/dev/null)
if [ -n "$topic" ] && [ "$topic" != "None" ]; then
  pass "Existe el tema de SNS lab-alertas"
  pending=$(aws sns list-subscriptions-by-topic --topic-arn "$topic" \
    --query "length(Subscriptions[?SubscriptionArn=='PendingConfirmation'])" --output text 2>/dev/null)
  total=$(aws sns list-subscriptions-by-topic --topic-arn "$topic" \
    --query "length(Subscriptions)" --output text 2>/dev/null)
  if [ "${total:-0}" -gt 0 ] && [ "${pending:-1}" -eq 0 ]; then
    pass "Suscripciones del tema confirmadas: $total"
  else
    bad "El tema tiene suscripciones sin confirmar o ninguna (revisa tu correo y spam)"
  fi
else
  bad "No existe el tema de SNS lab-alertas"
fi

echo
echo "Resultado: $ok pruebas correctas, $fail con problemas."
[ "$fail" -eq 0 ]
