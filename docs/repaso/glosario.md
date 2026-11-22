# Glosario

Términos del curso en orden alfabético, con el módulo donde se estudian. Los servicios llevan su nombre oficial en inglés. Usa el buscador del sitio (arriba) para encontrar un término rápido.

| Término | Definición | Módulo |
| --- | --- | --- |
| **ACL de red (NACL)** | Firewall **sin estado** a nivel de subred, con reglas de permitir y denegar evaluadas en orden numérico. | 5 |
| **Agilidad** | Capacidad de adaptarse rápido a requisitos o mercados que cambian. | 4 |
| **Alta disponibilidad** | Capacidad de un sistema de seguir accesible de forma continua, con el mínimo tiempo de inactividad, aunque falle un componente. Se logra con varias AZ o regiones. | 1, 4 |
| **Amazon API Gateway** | Servicio para crear, publicar y proteger API; puerta de entrada a tus servicios. | 5 |
| **Amazon Aurora** | Base de datos relacional compatible con MySQL y PostgreSQL, de alto rendimiento y con 6 copias en 3 AZ. | 7 |
| **Amazon Bedrock** | Servicio para crear aplicaciones de IA generativa con modelos fundacionales de varios proveedores. | 8 |
| **Amazon CloudFront** | Red de entrega de contenido (CDN) que usa las ubicaciones periféricas. | 4 |
| **Amazon CloudWatch** | Supervisión: métricas, registros, alarmas y paneles. | 2, 10 |
| **Amazon DynamoDB** | Base de datos NoSQL clave-valor sin servidor, con latencia de milisegundos. | 7 |
| **Amazon EBS** | Volúmenes de almacenamiento en bloque persistentes para EC2, ubicados en una AZ. | 6 |
| **Amazon EC2** | Servidores virtuales (instancias) redimensionables en la nube; servicio IaaS. | 2 |
| **Amazon ECR / ECS / EKS** | Registro de imágenes de contenedores / orquestador de AWS / Kubernetes administrado. | 3 |
| **Amazon EFS** | Sistema de archivos elástico y compartido para Linux (NFS). | 6 |
| **Amazon EventBridge** | Bus de eventos que enruta eventos a destinos según reglas. | 2 |
| **Amazon RDS** | Bases de datos relacionales administradas (Aurora, MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, Db2). | 7 |
| **Amazon Redshift** | Almacén de datos para analítica a gran escala. | 7, 8 |
| **Amazon S3** | Almacenamiento de objetos ilimitado con durabilidad de 11 nueves. | 1, 6 |
| **Amazon SageMaker AI** | Plataforma para preparar datos, entrenar, desplegar y monitorear modelos de ML. | 8 |
| **Amazon SNS** | Servicio de publicación/suscripción: empuja mensajes a todos los suscriptores de un tema. | 2 |
| **Amazon SQS** | Servicio de colas: guarda mensajes hasta que el consumidor los procesa. | 2 |
| **Amazon VPC** | Red virtual aislada de forma lógica dentro de AWS, donde lanzas tus recursos. | 5 |
| **AMI (imagen de máquina de Amazon)** | Plantilla con SO, almacenamiento, arquitectura, permisos y software para lanzar instancias idénticas. | 2 |
| **API** | Interfaz de programación de aplicaciones: formas predefinidas de interactuar con un servicio. Todo en AWS es una llamada a la API. | 2 |
| **Aprovisionar / desaprovisionar** | Crear o asignar un recurso / retirarlo, revocar accesos o eliminar configuraciones cuando ya no se necesita. | 1 |
| **AWS Artifact** | Portal de informes y acuerdos de cumplimiento de AWS. | 9 |
| **AWS CAF** | Marco de adopción de la nube con 6 perspectivas: negocio, personas, gobernanza, plataforma, seguridad y operaciones. | 12 |
| **AWS CLI** | Herramienta de línea de comandos para administrar AWS y automatizar con scripts. | 2 |
| **AWS CloudFormation** | Servicio de infraestructura como código: crea recursos a partir de plantillas. | 4 |
| **AWS CloudShell** | Terminal en el navegador con la AWS CLI lista para usar. | 2 |
| **AWS CloudTrail** | Registra las llamadas a la API de la cuenta: quién hizo qué y cuándo. | 10 |
| **AWS Config** | Inventario, historial de configuración y reglas de cumplimiento de los recursos. | 10 |
| **AWS Direct Connect** | Conexión de red privada y dedicada entre tu centro de datos y AWS, sin pasar por internet. | 5 |
| **AWS Elastic Beanstalk** | Servicio para desplegar aplicaciones web subiendo el código; crea EC2, ELB y Auto Scaling. | 3 |
| **AWS Fargate** | Motor de cómputo sin servidor para contenedores de ECS y EKS. | 3 |
| **AWS IAM** | Servicio de identidades y permisos: usuarios, grupos, roles y políticas. | 9 |
| **AWS KMS** | Servicio para crear y administrar claves de cifrado. | 9 |
| **AWS Lambda** | Servicio sin servidor que ejecuta código ante eventos, hasta 15 minutos, cobrando por milisegundo. | 3 |
| **AWS Organizations** | Gestión de varias cuentas con unidades organizativas, SCP y facturación consolidada. | 9, 10, 11 |
| **AWS Outposts** | Infraestructura y servicios de AWS instalados en el centro de datos del cliente. | 3 |
| **AWS PrivateLink** | Conecta tu VPC de forma privada a servicios como si estuvieran dentro de ella. | 5 |
| **AWS SDK** | Bibliotecas para usar AWS desde lenguajes de programación. | 2 |
| **AWS Shield / AWS WAF** | Protección contra DDoS / firewall de aplicaciones web (capa 7). | 9 |
| **AWS Transit Gateway** | Hub central que conecta muchas VPC y redes locales. | 5 |
| **AWS Trusted Advisor** | Recomendaciones de costo, rendimiento, seguridad, tolerancia a fallos, límites y operación. | 10, 11 |
| **AWS Well-Architected Framework** | Buenas prácticas de arquitectura organizadas en 6 pilares. | 13 |
| **CapEx / OpEx** | Gasto de capital (inversión inicial en hardware) frente a gasto operativo variable (pago por uso). | 1 |
| **Carga útil (payload)** | Datos que contiene un mensaje (cliente, pedido, hora). | 2 |
| **CDN** | Red de entrega de contenido: distribuye contenido desde sitios cercanos al usuario. | 4 |
| **CIDR** | Notación del rango de direcciones IP de una VPC o subred, por ejemplo `10.0.0.0/16`. | 5 |
| **Computación en la nube** | Entrega bajo demanda de recursos de TI por internet con pago por uso. | 1 |
| **Con estado / sin estado** | Con estado recuerda las conexiones y deja pasar la respuesta (grupo de seguridad); sin estado evalúa cada paquete por separado (ACL de red). | 5 |
| **Contenedor** | Paquete con la aplicación y todo lo que necesita para ejecutarse igual en cualquier lugar; comparte el SO del host. | 3 |
| **Desacoplamiento (acoplamiento débil)** | Diseño en el que los componentes funcionan de forma independiente: si uno falla, los demás siguen. | 2 |
| **EC2 Auto Scaling** | Agrega o quita instancias automáticamente entre una capacidad mínima y una máxima. | 2 |
| **Elastic Load Balancing (ELB)** | Distribuye el tráfico entrante entre recursos sanos, como instancias de EC2. | 2 |
| **Elasticidad** | Ajustar recursos automáticamente y en tiempo real según la demanda. | 2, 4 |
| **Escalabilidad** | Capacidad de un sistema de crecer agregando recursos. | 2 |
| **Escalado horizontal / vertical** | Agregar más máquinas (scale out) / dar más potencia a una máquina (scale up). | 2 |
| **Facturación consolidada** | Una sola factura para todas las cuentas de una organización, con descuentos por volumen combinados. | 11 |
| **Grupo de seguridad** | Firewall **con estado** a nivel de instancia, solo con reglas de permitir. | 5 |
| **Hipervisor** | Software que ejecuta y aísla varias máquinas virtuales sobre el mismo hardware. | 2 |
| **Host dedicado / instancia dedicada** | Servidor físico completo para ti (licencias BYOL) / hardware aislado para tu cuenta sin control del host. | 2 |
| **IaaS / PaaS / SaaS** | Infraestructura, plataforma o software como servicio, según cuánto administra el cliente. | 1 |
| **IaC (infraestructura como código)** | Definir la infraestructura en archivos de código para crearla de forma repetible. | 4 |
| **Instancias Spot** | Capacidad sobrante de EC2 con hasta 90 % de descuento; AWS puede recuperarla con 2 minutos de aviso. | 2 |
| **Latencia** | Tiempo que tardan los datos en viajar entre el usuario y el servidor. | 1, 4 |
| **MFA** | Autenticación multifactor: un segundo factor además de la contraseña. | 9 |
| **Multitenencia** | Compartir el hardware físico entre varios clientes, aislados por el hipervisor. | 2 |
| **NAT Gateway** | Permite que recursos de una subred privada salgan a internet sin ser accesibles desde afuera. | 5 |
| **Orquestación** | Automatizar el despliegue, escalado y administración de muchos contenedores. | 3 |
| **Política de IAM** | Documento JSON que permite o deniega acciones sobre recursos. | 9 |
| **Principio de privilegio mínimo** | Dar solo los permisos necesarios para una tarea. | 9 |
| **Puerta de enlace de internet (IGW)** | Conexión entre una VPC e internet. | 5 |
| **Puerta de enlace privada virtual** | Extremo de AWS de una conexión VPN; deja entrar solo tráfico de redes aprobadas. | 5 |
| **Región** | Área geográfica aislada con varios centros de datos agrupados en 3 o más AZ. | 1, 4 |
| **Responsabilidad compartida** | AWS protege la nube (infraestructura); el cliente protege lo que pone en la nube (datos, accesos, configuración). | 1, 9 |
| **Rol de IAM** | Identidad con permisos temporales que asumen servicios o personas. | 9 |
| **Savings Plans / instancias reservadas** | Descuentos a cambio de un compromiso de 1 o 3 años. | 2, 11 |
| **SCP (política de control de servicios)** | Límite máximo de permisos para las cuentas de una organización; no otorga permisos. | 9 |
| **Sin servidor (serverless)** | Modelo en el que no ves ni administras servidores; AWS gestiona el aprovisionamiento y el escalado. | 3 |
| **Subred** | Rango de direcciones IP dentro de una VPC; pública o privada; vive en una sola AZ. | 5 |
| **Tabla de rutas** | Reglas que deciden a dónde se envía el tráfico de una subred. | 5 |
| **Tolerancia a fallos** | Capacidad de un sistema de seguir operando aunque fallen uno o varios componentes, gracias a la redundancia. | 1 |
| **Ubicación periférica (edge location)** | Sitio que guarda contenido en caché cerca del usuario para bajar la latencia. | 1, 4 |
| **VPN** | Conexión cifrada por internet, como un túnel seguro (Client VPN para personas, Site-to-Site VPN para sedes). | 5 |
| **Zona de disponibilidad (AZ)** | Uno o más centros de datos con energía, red y conectividad redundantes dentro de una región. | 1, 4 |
| **7 R de la migración** | Retirar, retener, volver a alojar, reubicar, recomprar, redefinir la plataforma y refactorizar. | 12 |
