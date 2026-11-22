# Simulacro de examen · Módulos 1 a 5

!!! abstract "Instrucciones"
    25 preguntas al estilo del examen CLF-C02 sobre los módulos 1 a 5. Date **35 minutos**, anota tus respuestas y al final abre la sección de respuestas. Meta: **20 aciertos o más (80 %)**. El simulacro crecerá a medida que se publiquen los demás módulos.

**1.** Una startup quiere lanzar su producto sin comprar servidores y pagar solo lo que consuma. ¿Qué ventaja de la nube describe esto?

- a) Globalizarse en minutos
- b) Cambiar gasto de capital por gasto variable
- c) Economías de escala
- d) Alta disponibilidad

**2.** ¿Cuál es responsabilidad de AWS según el modelo de responsabilidad compartida?

- a) Configurar los grupos de seguridad
- b) Cifrar los datos del cliente
- c) La seguridad física de los centros de datos
- d) Parchear el sistema operativo de una instancia EC2

**3.** Una empresa necesita que su aplicación siga funcionando si falla un centro de datos completo. ¿Qué debe hacer?

- a) Usar una instancia más grande
- b) Desplegar en varias zonas de disponibilidad
- c) Usar más ubicaciones periféricas
- d) Comprar un host dedicado

**4.** Un hospital guarda historias clínicas en su centro de datos y publica su portal de citas en AWS. ¿Qué modelo de implementación usa?

- a) En la nube
- b) Local
- c) Híbrido
- d) SaaS

**5.** Un servidor de videojuegos necesita CPU de alto rendimiento. ¿Qué familia de instancias conviene?

- a) Optimizada para memoria
- b) Optimizada para cómputo
- c) Optimizada para almacenamiento
- d) Uso general

**6.** Una empresa ejecuta un ERP 24/7 y sabe que lo usará los próximos 3 años. ¿Qué opción reduce más su costo sin riesgo de interrupciones?

- a) Instancias Spot
- b) Bajo demanda
- c) Instancias reservadas o Savings Plans a 3 años
- d) Reservas de capacidad

**7.** ¿Qué opción permite usar licencias de software que se cobran por núcleo físico?

- a) Instancias dedicadas
- b) Hosts dedicados
- c) Instancias Spot
- d) Savings Plans

**8.** ¿Qué servicio ajusta automáticamente la cantidad de instancias de EC2 según la demanda?

- a) Elastic Load Balancing
- b) Amazon EC2 Auto Scaling
- c) Amazon CloudFront
- d) AWS CloudFormation

**9.** Si un componente de una aplicación falla, los pedidos no deben perderse. ¿Qué servicio desacopla los componentes guardando los mensajes?

- a) Amazon SNS
- b) Amazon SQS
- c) Amazon EventBridge
- d) Elastic Load Balancing

**10.** Un desarrollador quiere automatizar tareas de AWS con scripts desde su terminal. ¿Qué usa?

- a) La Consola de administración
- b) La AWS CLI
- c) Un host dedicado
- d) Una AMI

**11.** ¿Qué incluye una AMI?

- a) Solo la dirección IP de la instancia
- b) El sistema operativo, la configuración de almacenamiento, la arquitectura, los permisos de lanzamiento y el software adicional
- c) Las reglas del grupo de seguridad
- d) El plan de soporte

**12.** Un proceso de análisis dura 3 horas. ¿Por qué no conviene AWS Lambda?

- a) Lambda no admite Python
- b) Lambda tiene un máximo de 15 minutos por ejecución
- c) Lambda solo funciona con S3
- d) Lambda requiere administrar servidores

**13.** Un equipo quiere ejecutar contenedores sin administrar servidores. ¿Qué usa?

- a) Amazon ECR
- b) AWS Fargate
- c) Amazon EC2
- d) AWS Outposts

**14.** ¿Qué servicio permite subir el código de una aplicación web y que AWS cree la capacidad, el balanceo y el escalado?

- a) AWS Elastic Beanstalk
- b) AWS Batch
- c) Amazon Lightsail
- d) AWS Lambda

**15.** En AWS Lambda, ¿de qué es responsable el cliente?

- a) Del sistema operativo
- b) De su código y los permisos de la función
- c) Del hardware
- d) Del escalado de los servidores

**16.** Una empresa europea debe guardar los datos de sus clientes dentro de la UE. ¿Qué factor determina la región?

- a) Precio
- b) Proximidad
- c) Cumplimiento
- d) Disponibilidad de servicios

**17.** ¿Qué servicio entrega contenido desde ubicaciones periféricas para reducir la latencia?

- a) Amazon CloudFront
- b) AWS CloudFormation
- c) Amazon CloudWatch
- d) AWS CloudTrail

**18.** ¿Qué servicio crea el mismo entorno en varias regiones a partir de una plantilla?

- a) Amazon CloudFront
- b) AWS CloudFormation
- c) AWS Elastic Beanstalk
- d) Amazon Route 53

**19.** ¿Qué componente permite que el tráfico público de internet llegue a una VPC?

- a) Puerta de enlace privada virtual
- b) Puerta de enlace de internet
- c) NAT Gateway
- d) AWS PrivateLink

**20.** Una empresa necesita conectar su centro de datos con su VPC por internet de forma cifrada y rápida de configurar. ¿Qué usa?

- a) AWS Direct Connect
- b) AWS Site-to-Site VPN
- c) AWS Client VPN
- d) Amazon API Gateway

**21.** Una empresa mueve terabytes diarios entre su centro de datos y AWS y quiere una conexión privada con latencia estable. ¿Qué usa?

- a) AWS Site-to-Site VPN
- b) AWS Direct Connect
- c) Una puerta de enlace de internet
- d) AWS Client VPN

**22.** ¿Qué afirmación sobre los grupos de seguridad es correcta?

- a) Son sin estado y actúan a nivel de subred
- b) Son con estado, actúan a nivel de instancia y solo tienen reglas de permitir
- c) Permiten reglas de denegar
- d) Los configura AWS

**23.** Necesitas bloquear el tráfico de una dirección IP específica hacia toda una subred. ¿Qué usas?

- a) Un grupo de seguridad
- b) Una ACL de red
- c) Una AMI
- d) Una puerta de enlace de internet

**24.** Instancias en una subred privada necesitan descargar actualizaciones sin ser accesibles desde internet. ¿Qué necesitas?

- a) Una IP pública en cada instancia
- b) Un NAT Gateway
- c) AWS PrivateLink
- d) Una puerta de enlace privada virtual

**25.** ¿Qué hace pública a una subred?

- a) Tener instancias grandes
- b) Que su tabla de rutas tenga una ruta hacia una puerta de enlace de internet
- c) Estar en la zona de disponibilidad a
- d) Tener una ACL de red predeterminada

## Respuestas y explicaciones

??? success "Ver respuestas (después de terminar)"
    1. **b**: pagar por uso sin inversión inicial es cambiar CapEx por OpEx ([M1](../modulo-01/index.md)).
    2. **c**: la seguridad física es seguridad DE la nube (M1).
    3. **b**: varias AZ dan alta disponibilidad y tolerancia a fallos (M1, M4).
    4. **c**: combinar lo local con la nube es el modelo híbrido (M1).
    5. **b**: optimizada para cómputo, familia C ([M2](../modulo-02/index.md)).
    6. **c**: compromiso de 3 años con uso estable = RI o Savings Plans; Spot puede interrumpirse (M2).
    7. **b**: el host dedicado da visibilidad de sockets y núcleos físicos (M2).
    8. **b**: Auto Scaling cambia la cantidad de instancias; ELB reparte el tráfico (M2).
    9. **b**: SQS guarda los mensajes hasta que el consumidor los procesa (M2).
    10. **b**: la CLI se automatiza con scripts (M2).
    11. **b**: esos son los componentes de una AMI (M2).
    12. **b**: Lambda tiene un límite de 15 minutos ([M3](../modulo-03/index.md)).
    13. **b**: Fargate es cómputo sin servidor para contenedores (M3).
    14. **a**: Elastic Beanstalk aprovisiona el entorno a partir del código (M3).
    15. **b**: en lo sin servidor, el cliente gestiona código, permisos y datos (M3).
    16. **c**: las leyes de residencia de datos son un tema de cumplimiento ([M4](../modulo-04/index.md)).
    17. **a**: CloudFront es la CDN de AWS (M4).
    18. **b**: CloudFormation es infraestructura como código (M4).
    19. **b**: la puerta de enlace de internet conecta la VPC con internet ([M5](../modulo-05/index.md)).
    20. **b**: Site-to-Site VPN conecta redes completas por internet con cifrado (M5).
    21. **b**: Direct Connect es una línea privada dedicada (M5).
    22. **b**: grupo de seguridad = instancia, con estado, solo permitir (M5).
    23. **b**: solo las ACL de red tienen reglas de denegar y actúan sobre la subred (M5).
    24. **b**: el NAT Gateway permite salir sin aceptar conexiones entrantes (M5).
    25. **b**: la ruta 0.0.0.0/0 hacia la IGW hace pública a la subred (M5).

## Tu resultado

| Aciertos | Qué hacer |
| --- | --- |
| 23 a 25 | Excelente: sigue con el siguiente bloque de módulos |
| 20 a 22 | Bien: repasa las preguntas que fallaste en su módulo |
| Menos de 20 | Vuelve a las notas rápidas y a las trampas típicas de cada módulo |
