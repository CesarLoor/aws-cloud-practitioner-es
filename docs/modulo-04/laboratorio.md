# Laboratorio 4 · Infraestructura como código con CloudFormation

!!! example "Ficha del laboratorio"
    **Objetivo:** crear, actualizar, replicar en otra región y borrar infraestructura solo con código, y detectar un cambio manual con la detección de desviaciones.

    **Costo:** 0 USD (un bucket vacío) · **Tiempo:** 30 minutos · **Servicios:** CloudFormation, S3, CloudShell.

## Configuración previa

- Usuario administrador y región **us-east-1**.
- Las dos plantillas del laboratorio están en el repositorio: [`lab-bucket.yaml`](https://github.com/CesarLoor/aws-cloud-practitioner-es/blob/main/labs/modulo-04/lab-bucket.yaml) (versión inicial) y [`lab-bucket-v2.yaml`](https://github.com/CesarLoor/aws-cloud-practitioner-es/blob/main/labs/modulo-04/lab-bucket-v2.yaml) (con la etiqueta de la actualización). Descárgalas en tu computadora para la consola, o en CloudShell:

    ```bash
    BASE=https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-04
    curl -sO $BASE/lab-bucket.yaml && curl -sO $BASE/lab-bucket-v2.yaml
    ```

- Si prefieres escribirlas tú, usa un editor de texto, guarda en **UTF-8** con extensión `.yaml` y sangría de **2 espacios, sin tabulaciones**.

## Valores a usar

| Ajuste | Valor |
| --- | --- |
| Archivos | `lab-bucket.yaml` y `lab-bucket-v2.yaml` |
| Nombre de la pila | `lab-iac` |
| Región 1 | us-east-1 (Norte de Virginia) |
| Región 2 | sa-east-1 (São Paulo) |
| Etiqueta agregada en la actualización | `Curso = CLF-C02` |

## Paso a paso

1. Revisa la plantilla inicial:

    ```yaml
    --8<-- "labs/modulo-04/lab-bucket.yaml"
    ```

2. **CloudFormation → Crear pila → Con recursos nuevos → Cargar un archivo de plantilla** → elige `lab-bucket.yaml` → nombre de la pila `lab-iac` → deja lo demás por defecto → **Enviar**.
3. Revisa las pestañas **Eventos** (cómo se crea cada recurso), **Recursos** (el bucket) y **Salidas** (el nombre del bucket).
4. **Actualiza la pila** con `lab-bucket-v2.yaml`, que solo agrega estas líneas debajo de `Status: Enabled`:

    ```yaml
          Tags:
            - Key: Curso
              Value: CLF-C02
    ```

    **Actualizar → Reemplazar la plantilla actual** y revisa la **vista previa de cambios** antes de confirmar.

5. **Detección de desviaciones:** en S3, agrega a mano una etiqueta nueva al bucket (por ejemplo `Prueba = manual`). Después, en la pila: **Acciones de la pila → Detectar desviaciones** → **Ver resultados**. El bucket aparece como **MODIFIED**.
6. **Repetibilidad:** cambia a **sa-east-1** y crea la misma pila con el mismo archivo.

!!! tip "Todo el laboratorio desde CloudShell"
    ```bash
    aws cloudformation deploy --stack-name lab-iac --template-file lab-bucket.yaml          # crear
    aws cloudformation deploy --stack-name lab-iac --template-file lab-bucket-v2.yaml       # actualizar
    aws cloudformation deploy --stack-name lab-iac --template-file lab-bucket.yaml --region sa-east-1
    ```

## Pruebas de verificación

**Automáticas:** el script revisa las dos pilas, el versionado y la etiqueta del bucket y el resultado de la detección de desviaciones. Solo consulta.

```bash
curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-04/verificar-lab4.sh | bash
```

**Manuales** en CloudShell:

```bash
# Validar la plantilla
aws cloudformation validate-template --template-body file://lab-bucket.yaml

# Estado de la pila y nombre del bucket
aws cloudformation describe-stacks --stack-name lab-iac \
  --query "Stacks[0].[StackStatus,Outputs[0].OutputValue]" --output table

# Versionado y etiquetas del bucket
BUCKET=$(aws cloudformation describe-stacks --stack-name lab-iac \
  --query "Stacks[0].Outputs[?OutputKey=='NombreDelBucket'].OutputValue" --output text)
aws s3api get-bucket-versioning --bucket "$BUCKET"
aws s3api get-bucket-tagging --bucket "$BUCKET"

# Desviaciones
aws cloudformation detect-stack-drift --stack-name lab-iac
aws cloudformation describe-stack-resource-drifts --stack-name lab-iac \
  --query "StackResourceDrifts[].[LogicalResourceId,StackResourceDriftStatus]" --output table

# La misma pila en São Paulo
aws cloudformation describe-stacks --stack-name lab-iac --region sa-east-1 \
  --query "Stacks[0].StackStatus"
```

| Prueba | Resultado esperado |
| --- | --- |
| `validate-template` | Devuelve los parámetros y la descripción, sin errores |
| Estado de la pila | `CREATE_COMPLETE` o `UPDATE_COMPLETE` |
| Versionado | `"Status": "Enabled"` |
| Etiquetas | `Curso = CLF-C02` (más las etiquetas que agrega CloudFormation) |
| Desviaciones | `BucketLab` en `MODIFIED` después del cambio manual |
| sa-east-1 | `CREATE_COMPLETE` |

??? info "Ver el contenido del script de verificación"
    ```bash
    --8<-- "labs/modulo-04/verificar-lab4.sh"
    ```

## Errores comunes

- **`Template format error` o YAML mal formado:** hay tabulaciones o la sangría no coincide.
- **`ROLLBACK_COMPLETE`:** la creación falló. Busca en **Eventos** el primer `CREATE_FAILED`, elimina la pila y créala de nuevo (una pila en ese estado no se puede actualizar).
- **`No updates are to be performed`:** la plantilla no cambió.
- **`DELETE_FAILED` en el bucket:** tiene objetos. Vacíalo con el botón **Vaciar** de S3 (borra también todas las versiones) y elimina la pila otra vez.

## Limpieza verificada

1. Elimina la pila `lab-iac` en **us-east-1** y en **sa-east-1**: CloudFormation borra los buckets por ti.

    ```bash
    aws cloudformation delete-stack --stack-name lab-iac
    aws cloudformation delete-stack --stack-name lab-iac --region sa-east-1
    ```

2. Comprueba:

```bash
for r in us-east-1 sa-east-1; do
  echo "== $r"
  aws cloudformation list-stacks --region $r \
    --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE ROLLBACK_COMPLETE DELETE_FAILED \
    --query "StackSummaries[].StackName" --output text
done
aws s3 ls | grep lab-iac
```

No debe aparecer nada.

## Qué demuestra este laboratorio

- La IaC crea infraestructura coherente y repetible ([lección 4.3](4-3-iac-cloudformation.md)).
- La misma plantilla despliega en otra región en segundos: globalizarse en minutos ([lección 4.1](4-1-elegir-regiones.md) y módulo 1).
- CloudFormation detecta cambios manuales que rompen la coherencia ([lección 4.3](4-3-iac-cloudformation.md)).
