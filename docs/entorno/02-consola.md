# 2 · Recorrido por la consola de AWS

!!! abstract "Objetivo"
    Moverte con soltura por la Consola de administración de AWS y por CloudShell. **Tiempo:** 20 minutos.

## 1. Cómo entrar

Ve a [console.aws.amazon.com](https://console.aws.amazon.com/). Al principio entrarás como usuario raíz; después de la [configuración base](03-configuracion-base.md), con tu usuario administrador.

## 2. La barra de navegación

| Elemento | Para qué sirve | Truco |
| --- | --- | --- |
| **Logo de AWS** | Vuelve al inicio de la consola | — |
| **Servicios** | Menú con todos los servicios por categoría | Marca con ⭐ los que más usas para tenerlos en la barra |
| **Barra de búsqueda** | Busca servicios, funciones, documentación y artículos | Atajo **Alt + S** (Windows) u **Option + S** (Mac) |
| **CloudShell** (icono `>_`) | Terminal en el navegador con la AWS CLI lista | No necesita claves de acceso |
| **Notificaciones** (campana) | Eventos de AWS Health y avisos | — |
| **Ayuda** (?) | Documentación, soporte y re:Post | — |
| **Configuración** (engranaje) | Idioma, región predeterminada, modo claro u oscuro | Puedes cambiar el idioma a español |
| **Selector de región** | Región donde ves y creas recursos | En servicios globales (IAM, CloudFront, Route 53) dice **Global** |
| **Menú de la cuenta** | ID de la cuenta, Cuenta, Organización, Service Quotas, Billing and Cost Management, Credenciales de seguridad, Cerrar sesión | Copia el ID de cuenta desde aquí |

## 3. El inicio de la consola

Tiene **widgets** que puedes agregar, quitar y ordenar: visitados recientemente, estado de AWS (Health), costo y uso, crear una solución y novedades. Agrega el widget de **costo y uso** para vigilar el gasto de un vistazo.

## 4. La consola de un servicio

Casi todas siguen el mismo patrón:

- **Panel de navegación izquierdo** con las secciones del servicio (en EC2: Instancias, AMI, Volúmenes, Grupos de seguridad, Pares de claves, Balanceadores de carga, Auto Scaling).
- **Lista de recursos** en el centro, con filtros y búsqueda.
- Botones de **crear o lanzar** y menú **Acciones**.
- **Pestañas de detalle** del recurso seleccionado: Detalles, Seguridad, Redes, Almacenamiento, Supervisión y Etiquetas.

## 5. Servicios globales y regionales

| Globales | Regionales |
| --- | --- |
| IAM, Amazon CloudFront, Amazon Route 53, la facturación | Amazon EC2, Amazon VPC, AWS Lambda, Amazon RDS, AWS CloudFormation y la mayoría |

!!! note "Nota rápida"
    Los nombres de los buckets de S3 son únicos en todo el mundo, pero cada bucket vive en **una región**.

## 6. AWS CloudShell en 2 minutos

Terminal Linux en el navegador, gratuita, con la AWS CLI, Python, Node.js y git instalados. Usa tus permisos de la consola, así que no necesitas claves de acceso. Guarda hasta 1 GB por región en tu carpeta personal. Desde **Acciones** puedes subir y descargar archivos.

```bash
aws sts get-caller-identity                     # ¿quién soy?
aws ec2 describe-regions --output table         # regiones habilitadas
aws ec2 describe-availability-zones --region us-east-1 --output table
aws s3 ls                                       # mis buckets
```

## 7. Recorrido práctico

- [ ] Cambia el idioma de la consola (Configuración → Idioma).
- [ ] Elige **us-east-1** como región predeterminada.
- [ ] Marca como favoritos: EC2, S3, IAM, VPC, Lambda, CloudFormation, CloudShell y Billing and Cost Management.
- [ ] Busca EC2 con **Alt + S** y recorre su panel izquierdo.
- [ ] Cambia de región y observa cómo cambia el panel de EC2. Abre **EC2 Global View** para ver recursos de todas las regiones.
- [ ] Abre IAM y comprueba que el selector dice **Global**.
- [ ] Abre CloudShell y ejecuta `aws sts get-caller-identity`.
- [ ] Abre **Billing and Cost Management** y revisa la sección de capa gratuita o créditos.
- [ ] Agrega el widget de costo y uso al inicio de la consola.
- [ ] (Opcional) Instala la app móvil **AWS Console** para revisar alarmas y facturación.
