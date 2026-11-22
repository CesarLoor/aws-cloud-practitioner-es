# 5.8 Resumen del módulo y recursos

!!! abstract "Cierre del módulo de redes"
    Repaso de todo lo visto en el módulo y los recursos oficiales para profundizar.

## Recapitulación

En este módulo identificaste los componentes principales de las redes en AWS y cómo se conectan:

- **Amazon VPC** para aislar tus cargas de trabajo, dividida en **subredes** públicas y privadas ([5.1](5-1-vpc-subredes.md)).
- **Puertas de enlace**: de internet para el tráfico público y privada virtual para el tráfico cifrado de redes aprobadas ([5.2](5-2-puertas-enlace-vpn.md)).
- **Formas de conectarse**: Client VPN, Site-to-Site VPN, PrivateLink y Direct Connect, más Transit Gateway, NAT Gateway y API Gateway ([5.3](5-3-conectividad.md)).
- **Seguridad de red** en dos capas: ACL de red (subred, sin estado) y grupos de seguridad (instancia, con estado) ([5.4](5-4-grupos-seguridad-acl.md)).
- **Cómo se construye una VPC**: subredes en dos AZ, puerta de enlace de internet y tablas de rutas ([5.5](5-5-demostracion-vpc.md)).
- **Redes globales**: DNS con Route 53, contenido en caché con CloudFront y tráfico acelerado con Global Accelerator ([5.6](5-6-redes-globales.md)).
- **Arquitecturas globales**: VPN o Direct Connect con conmutación por error y entrega de contenido en varias regiones ([5.7](5-7-arquitecturas-globales.md)).

## Recursos oficiales

| Recurso | En una línea |
| --- | --- |
| [Amazon VPC](https://aws.amazon.com/vpc/) | Sección aislada de la nube donde lanzas tus recursos en una red que tú defines |
| [Subredes](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html) | Secciones de una VPC para organizar recursos, públicas o privadas |
| [Puerta de enlace de internet](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html) | Conexión entre la VPC e internet |
| [Puerta de enlace privada virtual](https://docs.aws.amazon.com/vpn/latest/s2svpn/how_it_works.html#VPNGateway) | Entrada para el tráfico cifrado de redes aprobadas |
| [AWS Client VPN](https://aws.amazon.com/vpn/client-vpn/) | VPN administrada y elástica para trabajadores remotos |
| [AWS Site-to-Site VPN](https://aws.amazon.com/vpn/site-to-site-vpn/) | Conexión cifrada entre tu centro de datos o sucursales y AWS |
| [AWS PrivateLink](https://docs.aws.amazon.com/vpc/latest/privatelink/what-is-privatelink.html) | Acceso privado a servicios como si estuvieran en tu VPC |
| [AWS Direct Connect](https://aws.amazon.com/directconnect/) | Conexión privada dedicada entre tu centro de datos y AWS |
| [ACL de red](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) | Filtrado sin estado a nivel de subred |
| [Grupos de seguridad](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html) | Filtrado con estado a nivel de instancia |
| [DNS](https://aws.amazon.com/route53/what-is-dns/) | Traduce nombres de dominio a direcciones IP |
| [Amazon Route 53](https://aws.amazon.com/route53/) | DNS, registro de dominios, comprobaciones de estado y enrutamiento |
| [Amazon CloudFront](https://aws.amazon.com/cloudfront/) | CDN que entrega contenido desde ubicaciones periféricas |
| [AWS Global Accelerator](https://aws.amazon.com/global-accelerator/) | Tráfico por la red global de AWS con IP estáticas |
| [AWS Transit Gateway](https://aws.amazon.com/transit-gateway/) | Hub que interconecta VPC y redes locales |
| [NAT Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html) | Salida a internet desde subredes privadas sin conexiones entrantes |
| [Amazon API Gateway](https://aws.amazon.com/api-gateway/) | Crear, publicar, proteger y supervisar API a cualquier escala |

## Siguiente paso

Haz la [evaluación del módulo](index.md#evaluacion-del-modulo) y el [Laboratorio 5](laboratorio.md), y repasa las [trampas típicas del examen](index.md#trampas-tipicas-del-examen) antes de pasar al módulo 6 (Almacenamiento).
