# Laboratorio 1 · Explora la infraestructura global y tu parte de la seguridad

!!! example "Ficha del laboratorio"
    **Objetivo:** ver con tus propios ojos las regiones y zonas de disponibilidad de AWS, distinguir servicios regionales y globales, y aplicar tu parte del modelo de responsabilidad compartida.

    **Costo:** 0 USD (solo consultas, no se crean recursos) · **Tiempo:** 25 minutos · **Servicios:** Consola de AWS, AWS CloudShell, IAM, Amazon EC2 (solo lectura).

## Antes de empezar

- Tener tu cuenta creada y la **configuración base** lista (MFA en el usuario raíz, usuario administrador, presupuesto de gasto cero). Está explicado paso a paso en [Crear tu cuenta](../entorno/01-crear-cuenta.md) y [Configuración base](../entorno/03-configuracion-base.md).
- Iniciar sesión con tu **usuario administrador**, no con el usuario raíz.

## Paso a paso

### Parte A · Las regiones en la consola

1. Abre la consola y mira el **selector de región** (arriba a la derecha). Elige **EE. UU. Este (Norte de Virginia) us-east-1**.
2. Busca **EC2** y abre su panel. Fíjate en el contador de recursos (instancias, volúmenes, etc.).
3. Cambia a **América del Sur (São Paulo) sa-east-1**: el panel de EC2 cambia, porque los recursos de EC2 son **regionales**.
4. Abre **IAM**: el selector ahora dice **Global**. IAM es un servicio global, igual que CloudFront y Route 53.

### Parte B · Regiones y AZ desde AWS CloudShell

Abre **CloudShell** (icono `>_` de la barra superior) y ejecuta:

```bash
# Regiones habilitadas en tu cuenta
aws ec2 describe-regions --query "Regions[].[RegionName,OptInStatus]" --output table

# Todas las regiones, incluidas las que requieren activación (opt-in)
aws ec2 describe-regions --all-regions --query "Regions[].[RegionName,OptInStatus]" --output table

# Zonas de disponibilidad de Norte de Virginia: nombre e ID físico
aws ec2 describe-availability-zones --region us-east-1 \
  --query "AvailabilityZones[].[ZoneName,ZoneId,State]" --output table

# Zonas de disponibilidad de São Paulo
aws ec2 describe-availability-zones --region sa-east-1 \
  --query "AvailabilityZones[].ZoneName" --output text
```

### Parte C · ¿Está disponible el servicio en mi región?

1. Abre [Servicios de AWS por región](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/).
2. Busca un servicio (por ejemplo, Amazon Bedrock) y compáralo entre us-east-1 y sa-east-1. Es el factor *disponibilidad de servicios* que estudiarás en el módulo 4.

### Parte D · Tu parte de la responsabilidad compartida

1. Abre **IAM → Panel**. Revisa **Recomendaciones de seguridad**: debe aparecer en verde *MFA para el usuario raíz* y que el usuario raíz **no tiene claves de acceso**.
2. Clasifica estas tareas como **Cliente** o **AWS**:

| Tarea | ¿Quién? |
| --- | --- |
| Activar MFA en el usuario raíz | ? |
| Reemplazar un disco dañado en un centro de datos | ? |
| Decidir quién puede ver un bucket de S3 | ? |
| Parchear el sistema operativo de una instancia EC2 | ? |
| Proteger el acceso físico a una zona de disponibilidad | ? |

??? success "Ver clasificación"
    Cliente · AWS · Cliente · Cliente · AWS

## Pruebas de verificación

Ejecuta el script del laboratorio en CloudShell. Solo hace consultas y marca cada prueba con ✅ o ❌:

```bash
curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-01/verificar-lab1.sh | bash
```

| Prueba | Resultado esperado |
| --- | --- |
| `aws sts get-caller-identity` | El ARN termina en `:user/<tu-usuario-admin>`, no en `:root`. |
| AZ de us-east-1 | Al menos 3 zonas en estado `available` (hoy son 6: us-east-1a a us-east-1f). |
| AZ de sa-east-1 | Al menos 3 zonas: sa-east-1a, sa-east-1b, sa-east-1c. |
| `--all-regions` | Algunas regiones aparecen como `not-opted-in`: son regiones que hay que activar antes de usarlas. |
| Recomendaciones de seguridad de IAM | MFA del usuario raíz en verde y sin claves de acceso del raíz. |

??? info "Ver el contenido del script"
    ```bash
    --8<-- "labs/modulo-01/verificar-lab1.sh"
    ```

!!! note "Dato fino"
    El nombre de una AZ (us-east-1a) puede apuntar a un centro de datos físico distinto en cada cuenta, para repartir la carga entre clientes. El **ZoneId** (por ejemplo, `use1-az1`) sí identifica la misma AZ física en todas las cuentas.

## Errores comunes

- **AccessDenied** en los comandos: el usuario con el que entraste no tiene permisos; usa tu usuario administrador.
- **CloudShell no aparece:** no está disponible en todas las regiones; cambia a us-east-1.
- **Faltan regiones en la lista:** sin `--all-regions` solo ves las regiones habilitadas en tu cuenta.

## Limpieza

No creaste recursos: no hay nada que borrar.

## Qué demuestra este laboratorio

- Las regiones son independientes y la mayoría de los recursos son regionales ([lección 1.2](1-2-infraestructura-global.md)).
- Cada región tiene como mínimo 3 AZ ([lección 1.2](1-2-infraestructura-global.md)).
- Proteger tu cuenta (MFA, usuarios, permisos) es tu responsabilidad ([lección 1.3](1-3-responsabilidad-compartida.md)).
