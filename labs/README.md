# Laboratorios

Scripts y plantillas que usan los laboratorios de la guía. Están pensados para ejecutarse en **AWS CloudShell** con tu usuario administrador (nunca con el usuario raíz).

| Archivo | Qué hace | ¿Crea recursos? |
| --- | --- | --- |
| [`comunes/presupuestos.yaml`](comunes/presupuestos.yaml) | Plantilla de CloudFormation: presupuesto de gasto cero y presupuesto mensual con alertas por correo | Sí (presupuestos de AWS Budgets) |
| [`comunes/verificar-configuracion.sh`](comunes/verificar-configuracion.sh) | Revisa la configuración base: usuario de IAM, MFA y claves del raíz, presupuestos, CLI v2 | No |
| [`comunes/verificar-limpieza.sh`](comunes/verificar-limpieza.sh) | Busca en todas las regiones recursos que cobran (EC2, NAT, IP elásticas, balanceadores, volúmenes) | No |
| [`modulo-01/verificar-lab1.sh`](modulo-01/verificar-lab1.sh) | Pruebas del Laboratorio 1: identidad, zonas de disponibilidad, regiones opt-in, seguridad del raíz | No |

Antes de ejecutar un script descargado de internet, léelo. Todos son cortos y comentados.
