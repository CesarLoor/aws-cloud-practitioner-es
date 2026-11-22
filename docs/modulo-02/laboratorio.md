# Laboratorio 2 · Servidor web en EC2 y mensajería con SQS y SNS

!!! example "Ficha del laboratorio"
    **Objetivo:** lanzar un servidor web en Amazon EC2, clonarlo con una AMI y comprobar en la práctica la diferencia entre una cola (SQS) y un tema de notificaciones (SNS).

    **Costo:** dentro de la capa gratuita o de tus créditos si usas un tipo apto y limpias al final · **Tiempo:** 45 minutos · **Servicios:** EC2, AMI, EBS, SQS, SNS, CloudShell.

## Configuración previa

1. Entra con tu **usuario administrador** (no el raíz) y elige la región **us-east-1**.
2. Comprueba que tu **presupuesto de gasto cero** está activo (Billing and Cost Management → Budgets).
3. **Crea el par de claves** antes de lanzar: EC2 → *Pares de claves* → *Crear par de claves* → nombre `lab-key`, tipo **RSA** o **ED25519**, formato **.pem** (sirve para OpenSSH, incluido en Windows 10/11, macOS y Linux). Guárdalo en la carpeta `.ssh` de tu usuario.

## Valores a usar

| Ajuste | Valor |
| --- | --- |
| Nombre y etiquetas | `lab-web` · etiqueta `Proyecto = lab-clf` |
| AMI | Amazon Linux 2023 (apta para la capa gratuita) |
| Tipo de instancia | `t3.micro` o `t2.micro` (la que diga *Apto para la capa gratuita*) |
| Par de claves | `lab-key` |
| Red | VPC predeterminada · cualquier subred · **Asignar IP pública automáticamente: Habilitar** |
| Grupo de seguridad | `lab-web-sg`: **HTTP (80)** desde `0.0.0.0/0` y **SSH (22)** desde **Mi IP** |
| Almacenamiento | 8 GiB gp3 (predeterminado) |
| Datos de usuario | El script de abajo |
| Cola de SQS | `lab-pedidos` (Estándar) |
| Tema de SNS | `lab-alertas` (Estándar) con suscripción de **correo** |

## Paso a paso

### Parte A · Servidor web

1. **EC2 → Lanzar instancia** y completa los valores de la tabla.
2. En **Detalles avanzados → Datos de usuario**, pega el script [`labs/modulo-02/datos-de-usuario.sh`](https://github.com/CesarLoor/aws-cloud-practitioner-es/blob/main/labs/modulo-02/datos-de-usuario.sh):

    ```bash
    --8<-- "labs/modulo-02/datos-de-usuario.sh"
    ```

3. **Lanza** y espera a que la instancia esté *En ejecución* con **2/2 comprobaciones superadas**.
4. Copia la **IPv4 pública** y abre `http://<IP>` en el navegador (con **http**, no https). Debe aparecer *Hola desde ip-...*.
5. **Conéctate por SSH** desde tu terminal:

    === "Windows (PowerShell)"

        ```powershell
        ssh -i $HOME\.ssh\lab-key.pem ec2-user@IP_PUBLICA
        ```

    === "macOS / Linux"

        ```bash
        chmod 400 ~/.ssh/lab-key.pem
        ssh -i ~/.ssh/lab-key.pem ec2-user@IP_PUBLICA
        ```

    Dentro de la instancia ejecuta `curl localhost` y `sudo systemctl status httpd`.

### Parte B · Repetibilidad con una AMI

1. Selecciona `lab-web` → **Acciones → Imagen y plantillas → Crear imagen**. Nombre: `lab-web-ami`.
2. Cuando la AMI esté *disponible*, lánzala (**AMI → Lanzar instancia desde AMI**) con el mismo grupo de seguridad, la etiqueta `Proyecto = lab-clf` y **sin** datos de usuario.
3. Abre la IP de la segunda instancia: muestra la misma página, porque el software ya venía en la AMI.

### Parte C · SQS frente a SNS

1. **SNS → Temas → Crear tema** (Estándar) `lab-alertas` → **Crear suscripción** → protocolo **Correo electrónico** → confirma el correo que te llega.
2. **Publica un mensaje** en el tema: llega al correo de inmediato (*push*).
3. **SQS → Crear cola** (Estándar) `lab-pedidos` → **Enviar y recibir mensajes** → envía `{"pedido": 123}` → **Sondear mensajes**: el mensaje esperó en la cola hasta que lo pediste (*pull*). Ábrelo y elimínalo.
4. **Fan-out:** en la cola, **Suscribirse a un tema de Amazon SNS** → `lab-alertas`. Publica otra vez en el tema: el mensaje llega al **correo y a la cola** a la vez.

## Pruebas de verificación

**Automáticas:** el script revisa las instancias, que el servidor web responda, las reglas del grupo de seguridad, la cola y el tema con su suscripción confirmada. Solo consulta.

```bash
curl -s https://raw.githubusercontent.com/CesarLoor/aws-cloud-practitioner-es/main/labs/modulo-02/verificar-lab2.sh | bash
```

**Manuales:** prueba tú mismo la cola y el tema desde CloudShell:

```bash
COLA=$(aws sqs get-queue-url --queue-name lab-pedidos --query QueueUrl --output text)
TEMA=$(aws sns list-topics --query "Topics[?ends_with(TopicArn, ':lab-alertas')].TopicArn" --output text)
aws sqs send-message --queue-url "$COLA" --message-body '{"pedido": 456}'
aws sqs receive-message --queue-url "$COLA"
aws sns publish --topic-arn "$TEMA" --message "Prueba desde CloudShell"
```

| Prueba | Resultado esperado |
| --- | --- |
| Instancias | Una o dos instancias `running` con IP pública |
| Servidor web | `<h1>Hola desde ip-...</h1>` |
| Grupo de seguridad | Puerto 80 con `0.0.0.0/0` y puerto 22 con tu IP `/32` |
| `receive-message` | Devuelve el mensaje con su `Body` |
| `sns publish` | Llega un correo y, con el fan-out, un mensaje nuevo en la cola |

??? info "Ver el contenido del script de verificación"
    ```bash
    --8<-- "labs/modulo-02/verificar-lab2.sh"
    ```

## Errores comunes

- **La página no carga:** abriste `https` en vez de `http`; falta la regla HTTP 80; la instancia no tiene IP pública; o el script de datos de usuario falló (por SSH revisa `sudo cat /var/log/cloud-init-output.log`). Espera 1 o 2 minutos después de 2/2.
- **`Permission denied (publickey)`:** el usuario de Amazon Linux es `ec2-user` y la clave debe ser la del par elegido.
- **`UNPROTECTED PRIVATE KEY FILE` en Windows:** la clave tiene permisos demasiado abiertos. En PowerShell:

    ```powershell
    icacls $HOME\.ssh\lab-key.pem /inheritance:r
    icacls $HOME\.ssh\lab-key.pem /grant:r "$($env:USERNAME):(R)"
    ```

- **EC2 Instance Connect (navegador) no conecta:** esa conexión sale desde direcciones de AWS, no desde tu IP. Para usarla, agrega una regla SSH con origen la lista de prefijos `com.amazonaws.us-east-1.ec2-instance-connect`, o conéctate por SSH desde tu terminal.
- **No llega el correo de SNS:** revisa spam y que la suscripción esté *Confirmada*.
- **`receive-message` no devuelve nada:** el mensaje está invisible durante el tiempo de visibilidad (30 s) o ya se eliminó.
- **La IP pública cambió:** al detener e iniciar una instancia, la IP pública cambia (salvo que uses una IP elástica, que tiene costo).

## Limpieza verificada

1. **Termina** las dos instancias.
2. **Anula el registro** de la AMI `lab-web-ami` y **elimina su snapshot** de EBS (EC2 → Instantáneas).
3. Elimina la cola `lab-pedidos` y el tema `lab-alertas`.
4. Comprueba en CloudShell:

```bash
aws ec2 describe-instances --filters "Name=tag:Proyecto,Values=lab-clf" \
  --query "Reservations[].Instances[].[InstanceId,State.Name]" --output table   # todas en terminated
aws ec2 describe-images --owners self --query "Images[].ImageId"                 # []
aws ec2 describe-snapshots --owner-ids self --query "Snapshots[].SnapshotId"     # []
aws sqs list-queues                                                              # sin lab-pedidos
aws sns list-topics                                                              # sin lab-alertas
```

Y termina con la [verificación global](../entorno/04-limpieza.md#2-verificacion-global-en-cloudshell).

## Qué demuestra este laboratorio

- Lanzar, conectar y usar una instancia ([lecciones 2.1](2-1-introduccion-ec2.md) y [2.4](2-4-lanzar-instancia-ami.md)).
- La AMI hace que las instancias sean repetibles ([lección 2.4](2-4-lanzar-instancia-ami.md)).
- El grupo de seguridad controla qué tráfico entra (lección 2.1 y módulo 5).
- SQS guarda mensajes hasta que alguien los saca; SNS los empuja a todos los suscriptores ([lección 2.8](2-8-mensajeria-desacoplamiento.md)).
