#!/usr/bin/env bash
# Revisa todas las regiones habilitadas en busca de recursos que cobran. Solo consulta: no borra nada.
# Uso en AWS CloudShell:
#   curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/comunes/verificar-limpieza.sh | bash
set -u
found=0
for r in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text); do
  inst=$(aws ec2 describe-instances --region "$r" \
    --filters "Name=instance-state-name,Values=pending,running,stopping,stopped" \
    --query "Reservations[].Instances[].InstanceId" --output text)
  nat=$(aws ec2 describe-nat-gateways --region "$r" \
    --filter "Name=state,Values=pending,available" \
    --query "NatGateways[].NatGatewayId" --output text)
  eip=$(aws ec2 describe-addresses --region "$r" --query "Addresses[].PublicIp" --output text)
  lb=$(aws elbv2 describe-load-balancers --region "$r" --query "LoadBalancers[].LoadBalancerName" --output text)
  vol=$(aws ec2 describe-volumes --region "$r" --filters "Name=status,Values=available" \
    --query "Volumes[].VolumeId" --output text)
  if [ -n "$inst$nat$eip$lb$vol" ]; then
    found=1
    echo "ATENCION $r -> instancias: $inst | NAT: $nat | IP elasticas: $eip | balanceadores: $lb | volumenes sueltos: $vol"
  fi
done
if [ "$found" -eq 0 ]; then
  echo "Revision terminada: no hay recursos de computo o red cobrando."
else
  echo "Revision terminada: elimina los recursos marcados con ATENCION."
fi
echo "Buckets de S3 (son globales, revisa que solo queden los que quieres):"
aws s3 ls
