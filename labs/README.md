# Laboratorios

Scripts, código y plantillas que usan los laboratorios de la guía. Están pensados para ejecutarse en **AWS CloudShell** con tu usuario administrador (nunca con el usuario raíz). Cada página de laboratorio indica el comando exacto para descargarlos.

| Archivo | Qué hace | ¿Crea recursos? |
| --- | --- | --- |
| [`comunes/presupuestos.yaml`](comunes/presupuestos.yaml) | Plantilla de CloudFormation: presupuesto de gasto cero y presupuesto mensual con alertas por correo | Sí (presupuestos de AWS Budgets) |
| [`comunes/verificar-configuracion.sh`](comunes/verificar-configuracion.sh) | Revisa la configuración base: usuario de IAM, MFA y claves del raíz, presupuestos, CLI v2 | No |
| [`comunes/verificar-limpieza.sh`](comunes/verificar-limpieza.sh) | Busca en todas las regiones recursos que cobran (EC2, NAT, IP elásticas, balanceadores, volúmenes) | No |
| [`modulo-01/verificar-lab1.sh`](modulo-01/verificar-lab1.sh) | Pruebas del Laboratorio 1: identidad, zonas de disponibilidad, regiones opt-in, seguridad del raíz | No |
| [`modulo-02/datos-de-usuario.sh`](modulo-02/datos-de-usuario.sh) | Datos de usuario de EC2: instala Apache y publica una página | Se ejecuta dentro de la instancia |
| [`modulo-02/verificar-lab2.sh`](modulo-02/verificar-lab2.sh) | Pruebas del Laboratorio 2: instancias, servidor web, grupo de seguridad, SQS y SNS | No |
| [`modulo-03/lambda_saludo.py`](modulo-03/lambda_saludo.py) | Código de la función Lambda de la parte A | Se pega en la consola de Lambda |
| [`modulo-03/lambda_s3.py`](modulo-03/lambda_s3.py) | Código de la función Lambda con desencadenador de S3 (parte B) | Se pega en la consola de Lambda |
| [`modulo-03/verificar-lab3.sh`](modulo-03/verificar-lab3.sh) | Pruebas del Laboratorio 3: función, desencadenador de S3, registros y Beanstalk | No |
| [`modulo-04/lab-bucket.yaml`](modulo-04/lab-bucket.yaml) | Plantilla de CloudFormation: bucket con versionado | Sí (un bucket vacío) |
| [`modulo-04/lab-bucket-v2.yaml`](modulo-04/lab-bucket-v2.yaml) | La misma plantilla con una etiqueta, para practicar la actualización | Sí (actualiza la pila) |
| [`modulo-04/verificar-lab4.sh`](modulo-04/verificar-lab4.sh) | Pruebas del Laboratorio 4: pilas en dos regiones, versionado, etiqueta y desviaciones | No |
| [`modulo-05/verificar-lab5.sh`](modulo-05/verificar-lab5.sh) | Pruebas del Laboratorio 5: VPC, rutas, IP de las instancias, NAT, servidor web y ACL de red | No |

Antes de ejecutar un script descargado de internet, léelo. Todos son cortos y comentados, y cada página de laboratorio muestra su contenido.
