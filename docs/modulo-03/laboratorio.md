# Laboratorio 3 · Función Lambda con desencadenador de S3 (+ Elastic Beanstalk)

!!! example "Ficha del laboratorio"
    **Objetivo:** ejecutar código sin crear servidores, ver cómo se factura una función y conectar un evento real de Amazon S3 con AWS Lambda. Opcional: desplegar una app con Elastic Beanstalk y ver qué recursos crea.

    **Costo:** 0 USD dentro de la capa gratuita de Lambda y S3 (Beanstalk usa una instancia EC2: termínala al final) · **Tiempo:** 40 minutos · **Servicios:** Lambda, S3, CloudWatch Logs, IAM, Elastic Beanstalk.

## Configuración previa

- Región **us-east-1** y tu **usuario administrador**.
- **Rol de ejecución de Lambda:** al crear la función, deja la opción *Crear un rol nuevo con permisos básicos de Lambda*. Ese rol permite escribir registros en CloudWatch.
- **Nombre del bucket:** único en todo el mundo, en minúsculas, sin guiones bajos y de 3 a 63 caracteres (por ejemplo, `lab-fotos-xyz-2026`). Deja activado *Bloquear todo el acceso público*.
- **Solo para la Parte C (Beanstalk):** si la consola no ofrece crear el perfil de instancia de EC2, créalo en **IAM → Roles → Crear rol → Servicio de AWS → EC2**, con las políticas `AWSElasticBeanstalkWebTier`, `AWSElasticBeanstalkWorkerTier` y `AWSElasticBeanstalkMulticontainerDocker`, y nombre `aws-elasticbeanstalk-ec2-role`. El rol de servicio sí puede crearlo la consola.

## Valores a usar

| Ajuste | Valor |
| --- | --- |
| Función | `lab-saludo` · Python 3 (la versión más reciente) · arquitectura x86_64 |
| Memoria y tiempo de espera | 128 MB y 3 s (predeterminados) |
| Evento de prueba | `lab-test` con `{"nombre": "AWS"}` |
| Bucket | `lab-fotos-<iniciales>-<número>` |
| Desencadenador | S3 → *All object create events* |
| Beanstalk (opcional) | Aplicación `lab-beanstalk` · plataforma Python · *Aplicación de ejemplo* · preset **Instancia única (apta para la capa gratuita)** |

## Paso a paso

### Parte A · Hola, Lambda

1. **Lambda → Crear función → Crear desde cero** con los valores de la tabla.
2. Reemplaza el código por [`labs/modulo-03/lambda_saludo.py`](https://github.com/CesarLoor/aws-cloud-practitioner-es/blob/main/labs/modulo-03/lambda_saludo.py) y pulsa **Deploy**:

    ```python
    --8<-- "labs/modulo-03/lambda_saludo.py"
    ```

3. Pestaña **Test** → crea el evento `lab-test` → **Test**. Mira la respuesta, la **duración** y la **duración facturada**: eso es lo que pagas.
4. Pestaña **Monitor** → **Ver registros de CloudWatch**: cada ejecución queda registrada.
5. **Configuración → Configuración general → Editar:** comprueba que el tiempo de espera máximo es **15 min 0 s**.

### Parte B · Arquitectura basada en eventos con S3

1. Crea el bucket en **S3** (misma región).
2. En la función: **Agregar desencadenador → S3** → tu bucket → tipo de evento *All object create events* → marca la casilla de reconocimiento.
3. Cambia el código por [`labs/modulo-03/lambda_s3.py`](https://github.com/CesarLoor/aws-cloud-practitioner-es/blob/main/labs/modulo-03/lambda_s3.py) y pulsa **Deploy**:

    ```python
    --8<-- "labs/modulo-03/lambda_s3.py"
    ```

4. Sube cualquier archivo al bucket y revisa los registros en CloudWatch: aparece su nombre.

### Parte C (opcional) · Elastic Beanstalk

1. **Elastic Beanstalk → Crear aplicación** con los valores de la tabla.
2. Cuando el entorno esté en verde (*Ok*), abre su URL: verás la aplicación de ejemplo.
3. Revisa en **EC2** la instancia creada y en **CloudFormation** la pila que Beanstalk generó por ti: es infraestructura como código que no tuviste que escribir.

## Pruebas de verificación

**Automáticas:** el script revisa la función, su desencadenador de S3, los registros en CloudWatch y, si existe, el entorno de Beanstalk. Solo consulta.

```bash
curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-03/verificar-lab3.sh | bash
```

**Manuales** en CloudShell:

```bash
# Parte A: invocar la función con un evento propio (antes de cambiar el código en la Parte B)
aws lambda invoke --function-name lab-saludo \
  --cli-binary-format raw-in-base64-out \
  --payload '{"nombre": "CloudShell"}' respuesta.json && cat respuesta.json

# Parte B: subir un archivo y ver el registro (reemplaza el bucket)
echo "hola" > prueba.txt
aws s3 cp prueba.txt s3://NOMBRE_DEL_BUCKET/
aws logs tail /aws/lambda/lab-saludo --since 5m

# Parte C: estado y URL del entorno de Beanstalk
aws elasticbeanstalk describe-environments \
  --query "Environments[].[EnvironmentName,Health,CNAME]" --output table
```

| Prueba | Resultado esperado |
| --- | --- |
| `lambda invoke` | `{"statusCode": 200, "body": "{\"mensaje\": \"Hola, CloudShell!\"}"}` |
| `logs tail` | Una línea `Nuevo archivo: prueba.txt` |
| Beanstalk | Salud `Green` y un CNAME que abre la app de ejemplo |

??? info "Ver el contenido del script de verificación"
    ```bash
    --8<-- "labs/modulo-03/verificar-lab3.sh"
    ```

## Errores comunes

- **`KeyError: 'Records'`** al usar el botón Test después de la Parte B: tu evento de prueba no tiene formato de S3. Usa la plantilla de evento **s3-put** o prueba subiendo un archivo real.
- **No aparecen registros:** espera unos segundos; revisa que el rol tenga la política `AWSLambdaBasicExecutionRole`.
- **El bucket "ya existe":** los nombres son globales; agrega números.
- **Nunca hagas que la función escriba en el mismo bucket que la dispara:** se invocaría a sí misma en bucle, con el costo que eso implica.
- **Beanstalk falla al crear el entorno** por el perfil de instancia: créalo como se explica en la configuración previa.

## Limpieza verificada

1. Elimina la función `lab-saludo` y su grupo de registros `/aws/lambda/lab-saludo`.
2. Vacía y elimina el bucket.
3. Beanstalk: **Acciones → Terminar entorno** y luego elimina la aplicación. Beanstalk deja un bucket `elasticbeanstalk-us-east-1-<cuenta>`; para borrarlo, elimina primero su **política de bucket**.
4. Comprueba:

```bash
aws lambda list-functions --query "Functions[].FunctionName"                    # sin lab-saludo
aws s3 ls                                                                         # sin tus buckets del lab
aws elasticbeanstalk describe-environments \
  --query "Environments[?Status!='Terminated'].EnvironmentName"                   # []
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" \
  --query "Reservations[].Instances[].InstanceId"                                 # []
```

Y termina con la [verificación global](../entorno/04-limpieza.md#2-verificacion-global-en-cloudshell).

## Qué demuestra este laboratorio

- Lo sin servidor: código que se ejecuta sin que veas servidores, facturado por milisegundo ([lecciones 3.1](3-1-administrados-sin-servidor.md) y [3.2](3-2-aws-lambda.md)).
- La arquitectura basada en eventos: S3 dispara Lambda ([lección 3.2](3-2-aws-lambda.md)).
- Un servicio administrado: Beanstalk crea EC2, Auto Scaling y más a partir de tu código ([lección 3.4](3-4-otros-servicios-computo.md)).
