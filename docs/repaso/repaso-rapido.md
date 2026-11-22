# Repaso rápido para el examen

!!! tip "Hoja de repaso"
    Lo esencial de cada módulo y los servicios que más se confunden. Úsala el día antes de un examen o después de cada bloque de módulos. Se amplía cada vez que se publica un módulo.

## Módulo 1 · Introducción a la nube

- Nube = **bajo demanda + internet + pago por uso**. Modelos: **nube, local, híbrido**.
- **6 ventajas:** CapEx→OpEx, economías de escala, no adivinar capacidad, velocidad y agilidad, no operar centros de datos, globalizarse en minutos.
- **Región ⊃ AZ (mínimo 3) ⊃ centros de datos.** Ubicaciones periféricas fuera de las regiones.
- **AWS = seguridad DE la nube** · **cliente = seguridad EN la nube**. Tus datos y accesos siempre son tuyos.

## Módulo 2 · Cómputo en la nube

- EC2 = IaaS; **multitenencia** aislada por el hipervisor. Lanzar = **AMI + tipo de instancia**.
- Familias: general, **C** cómputo, **R/X** memoria, **P/G/Inf/Trn** aceleradas, **I/D** almacenamiento.
- **Spot 90 % > RI ≈ Savings Plans 72 % > bajo demanda.** Host dedicado = BYOL. Reservas de capacidad = sin descuento.
- **Auto Scaling** = cuántas instancias (mínima, deseada, máxima) · **ELB** = reparte el tráfico.
- **SQS** = cola (pull) · **SNS** = pub/sub (push) · **EventBridge** = eventos con reglas.

## Módulo 3 · Servicios de cómputo

- No administrado (EC2) → administrado (RDS, Beanstalk) → sin servidor (Lambda, Fargate).
- **Lambda:** eventos, máx. **15 min**, pago por ms.
- **ECR** guarda imágenes · **ECS/EKS** orquestan · **Fargate** ejecuta sin servidores.
- **Beanstalk** = sube tu código · **Batch** = lotes · **Lightsail** = simple y precio fijo · **Outposts** = AWS en tu sitio.

## Módulo 4 · Hacia la globalización

- Elegir región: **cumplimiento → proximidad → servicios → precio**.
- Varias AZ = alta disponibilidad; varias regiones = recuperación ante desastres.
- **CloudFront** usa ubicaciones periféricas (caché). **CloudFormation** = IaC (plantilla → pila), sin costo propio.

## Módulo 5 · Redes

- **VPC** aislada · **subred** en una sola AZ · pública = ruta a la **IGW**.
- **Client VPN** personas · **Site-to-Site VPN** sedes · **Direct Connect** línea dedicada · **PrivateLink** servicios sin internet.
- **Transit Gateway** hub · **NAT Gateway** solo salida · **API Gateway** puerta de las API.
- **Grupo de seguridad:** instancia, con estado, solo permitir · **ACL de red:** subred, sin estado, permitir y denegar.

## Módulos 6 a 13 en una línea

- **6 Almacenamiento:** EBS (bloque) · S3 (objeto, 11 nueves) · EFS/FSx (archivo) · Glacier (archivo barato) · Storage Gateway (híbrido).
- **7 Bases de datos:** RDS/Aurora (SQL) · DynamoDB (NoSQL sin servidor) · ElastiCache (caché) · Redshift (analítica) · DMS (migrar).
- **8 IA/ML y análisis:** servicios de IA listos · Bedrock y Q (generativa) · SageMaker AI (ML propio) · Athena, Glue, Kinesis, QuickSight.
- **9 Seguridad:** IAM (privilegio mínimo, MFA, roles) · Organizations/SCP · Artifact · Shield, WAF · KMS · GuardDuty, Inspector, Macie.
- **10 Supervisión:** CloudWatch (rendimiento) · CloudTrail (quién hizo qué) · Config (configuración) · Trusted Advisor (recomendaciones).
- **11 Precios y soporte:** Pricing Calculator, Cost Explorer, Budgets · facturación consolidada · planes Basic a Enterprise.
- **12 Migración:** AWS CAF (6 perspectivas) · 7 R · Application Migration Service, DMS, DataSync.
- **13 Well-Architected:** 6 pilares · Well-Architected Tool · estrategias de recuperación ante desastres.

## Servicios que se confunden

| Si la pregunta habla de… | Es… | No confundir con… |
| --- | --- | --- |
| Rendimiento, métricas, alarmas | CloudWatch | CloudTrail (auditoría de la API) |
| Quién hizo qué y cuándo | CloudTrail | Config (estado de la configuración) |
| Infraestructura como código | CloudFormation | CloudFront (CDN) |
| Guardar mensajes hasta procesarlos | SQS | SNS (notificar a muchos) |
| Firewall de instancia, con estado | Grupo de seguridad | ACL de red (subred, sin estado) |
| Conexión privada dedicada | Direct Connect | Site-to-Site VPN (por internet, cifrada) |
| Ataques DDoS | Shield | WAF (ataques web de capa 7) |
| Amenazas en la cuenta | GuardDuty | Inspector (vulnerabilidades) y Macie (datos sensibles) |
| Disco de una instancia | EBS | EFS (archivos compartidos) y S3 (objetos) |
| Estimar antes de gastar | Pricing Calculator | Cost Explorer (lo ya gastado) y Budgets (alertas) |
| Contenedores sin servidores | Fargate | ECS/EKS (orquestadores) |
| AWS en tu centro de datos | Outposts | Direct Connect (conexión de red) |
