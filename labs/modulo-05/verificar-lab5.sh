#!/usr/bin/env bash
# Laboratorio 5 · Pruebas de verificación. Solo consulta: no crea ni borra nada.
# Uso en AWS CloudShell (región us-east-1):
#   curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-05/verificar-lab5.sh | bash
set -u
ok=0
fail=0
pass() { echo "✅ $1"; ok=$((ok + 1)); }
bad() { echo "❌ $1"; fail=$((fail + 1)); }

vpc=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=lab-vpc" --query "Vpcs[0].VpcId" --output text 2>/dev/null) || {
  echo "❌ No se pudo usar la AWS CLI. Ejecuta este script en AWS CloudShell."
  exit 1
}
if [ -z "$vpc" ] || [ "$vpc" = "None" ]; then
  echo "❌ No existe la VPC lab-vpc en esta región (paso 1)."
  exit 1
fi
pass "Existe la VPC lab-vpc ($vpc)"

igw_routes=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpc" \
  --query "length(RouteTables[?Routes[?DestinationCidrBlock=='0.0.0.0/0' && starts_with(GatewayId || '', 'igw-')]])" --output text)
if [ "${igw_routes:-0}" -ge 1 ]; then pass "Hay una tabla de rutas pública con 0.0.0.0/0 hacia la IGW"; else bad "Ninguna tabla de rutas envía 0.0.0.0/0 a la IGW"; fi

nat=$(aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values=$vpc" "Name=state,Values=pending,available" \
  --query "NatGateways[].NatGatewayId" --output text)
if [ -z "$nat" ]; then pass "No hay NAT Gateway (bien: evitas su costo por hora)"; else bad "Hay un NAT Gateway ($nat): elimínalo, cobra por hora"; fi

pub_ip=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpc" "Name=instance-state-name,Values=running" "Name=tag:Name,Values=lab-publica" \
  --query "Reservations[].Instances[].PublicIpAddress" --output text)
priv_ip=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$vpc" "Name=instance-state-name,Values=running" "Name=tag:Name,Values=lab-privada" \
  --query "Reservations[].Instances[].PublicIpAddress" --output text)
if [ -n "$pub_ip" ] && [ "$pub_ip" != "None" ]; then pass "lab-publica tiene IP pública: $pub_ip"; else bad "lab-publica no está en ejecución o no tiene IP pública"; fi
if [ "$priv_ip" = "None" ]; then pass "lab-privada no tiene IP pública"; elif [ -z "$priv_ip" ]; then bad "lab-privada no está en ejecución"; else bad "lab-privada tiene IP pública ($priv_ip): debería no tenerla"; fi

if [ -n "$pub_ip" ] && [ "$pub_ip" != "None" ]; then
  if curl -s -m 5 "http://$pub_ip" | grep -q "Hola desde"; then
    pass "El servidor web de lab-publica responde (ACL y grupo de seguridad lo permiten)"
  else
    echo "ℹ️  El servidor web no responde. Es lo esperado en los experimentos 1, 3 y 4; si terminaste el 5, revisa las reglas."
  fi
fi

nacl=$(aws ec2 describe-network-acls --filters "Name=vpc-id,Values=$vpc" "Name=tag:Name,Values=lab-nacl" \
  --query "NetworkAcls[0].NetworkAclId" --output text)
if [ -n "$nacl" ] && [ "$nacl" != "None" ]; then
  pass "Existe la ACL personalizada lab-nacl ($nacl)"
  in80=$(aws ec2 describe-network-acls --network-acl-ids "$nacl" \
    --query "length(NetworkAcls[0].Entries[?Egress==\`false\` && RuleAction=='allow' && PortRange.From==\`80\`])" --output text)
  outeph=$(aws ec2 describe-network-acls --network-acl-ids "$nacl" \
    --query "length(NetworkAcls[0].Entries[?Egress==\`true\` && RuleAction=='allow' && PortRange.From==\`1024\` && PortRange.To==\`65535\`])" --output text)
  if [ "${in80:-0}" -ge 1 ]; then pass "lab-nacl permite la entrada al puerto 80"; else bad "lab-nacl no tiene la regla de entrada al puerto 80 (experimento 4)"; fi
  if [ "${outeph:-0}" -ge 1 ]; then pass "lab-nacl permite la salida a los puertos efímeros 1024-65535"; else bad "lab-nacl no permite la salida a puertos efímeros (experimento 5)"; fi
else
  bad "No existe la ACL lab-nacl (experimento 3)"
fi

echo
echo "Resultado: $ok pruebas correctas, $fail con problemas."
[ "$fail" -eq 0 ]
