# 2.4 Demostración: lanzar una instancia y las AMI

!!! abstract "En esta lección aprenderás a"
    Identificar las configuraciones clave para lanzar una instancia de EC2 · explicar cómo una AMI mantiene la coherencia y la eficiencia al escalar aplicaciones · entender el ciclo de vida de una instancia.

## 1. El asistente de lanzamiento paso a paso

En la demostración del curso se lanza una instancia desde la consola. Estas son las secciones del asistente y qué decide cada una:

| Sección | Qué defines | Valor típico para practicar |
| --- | --- | --- |
| **Nombre y etiquetas** | Cómo identificarás la instancia | `lab-web` · etiqueta `Proyecto=lab-clf` |
| **AMI** | Sistema operativo y software | Amazon Linux 2023 |
| **Tipo de instancia** | CPU y memoria | t3.micro o t2.micro (aptas para la capa gratuita) |
| **Par de claves** | Credencial para entrar por SSH o descifrar la contraseña de Windows | Uno nuevo, por ejemplo `lab-key` |
| **Configuración de red** | VPC, subred, IP pública y **grupo de seguridad** | VPC predeterminada; HTTP abierto, SSH solo desde tu IP |
| **Almacenamiento** | Volumen raíz (EBS): tamaño y tipo | 8 GiB gp3 |
| **Detalles avanzados** | Datos de usuario (script de arranque), rol de IAM, etc. | Script que instala un servidor web |
| **Número de instancias** | Cuántas lanzar con la misma configuración | 1 |

Lo harás tú mismo, con estos valores, en el [Laboratorio 2](laboratorio.md).

## 2. Imágenes de máquina de Amazon (AMI)

### Componentes de una AMI

Una AMI es la **plantilla** a partir de la cual se crea una instancia. Incluye:

- El **sistema operativo**.
- La **configuración del almacenamiento** (qué volúmenes se crean y de qué tamaño).
- El **tipo de arquitectura** (x86_64 o ARM64).
- Los **permisos de lanzamiento** (quién puede usarla: solo tu cuenta, cuentas específicas o pública).
- Cualquier **software adicional** ya instalado.

Con una misma AMI puedes lanzar **muchas instancias con la misma configuración**.

### Tres maneras de obtener una AMI

| Origen | Qué es | Cuándo usarla |
| --- | --- | --- |
| **AMI propia (personalizada)** | La creas tú a partir de una instancia ya configurada | Tienes software y ajustes específicos que quieres repetir |
| **AMI de AWS (preconfigurada)** | Preparada por AWS para sistemas y software comunes (Amazon Linux, Ubuntu, Windows Server…) | Empezar rápido con una base confiable |
| **AWS Marketplace** | AMI de proveedores externos con software especializado (firewalls, bases de datos, etc.) | Necesitas un producto comercial listo para usar |

### Capacidad de repetición

Como cada instancia nueva parte de **la misma AMI**, los entornos de desarrollo, prueba y producción quedan **idénticos** y las implementaciones se automatizan. Eso **facilita escalar, reduce errores** y simplifica administrar entornos grandes. A una AMI preparada con todo lo necesario se le suele llamar *golden image*.

!!! note "Nota rápida"
    Las AMI son **regionales**. Para usar la misma AMI en otra región, primero la **copias** a esa región.

## 3. Ciclo de vida de una instancia y facturación

| Estado | Qué pasa | ¿Se cobra el cómputo? |
| --- | --- | --- |
| **pending** | Se está preparando | No |
| **running** | En ejecución | **Sí** |
| **stopping / stopped** | Detenida; los discos EBS se conservan | No, pero **sí** el almacenamiento EBS |
| **terminated** | Eliminada definitivamente | No |

!!! danger "Ojo con la factura"
    Detener una instancia no la elimina. Si no la vas a usar más, **termínala**; si creaste una AMI, elimina también su *snapshot*.

## Comprueba lo aprendido

**1.** Nombra tres componentes de una AMI.

**2.** Una empresa necesita un firewall comercial ya configurado en EC2. ¿De dónde obtiene la AMI?

**3.** ¿Se cobra una instancia detenida?

??? success "Ver respuestas"
    1. SO, configuración de almacenamiento, arquitectura, permisos de lanzamiento y software adicional (cualquiera de esos tres).
    2. De **AWS Marketplace**.
    3. El cómputo no, pero sí sus volúmenes EBS.

## Para profundizar

- [AMI de Amazon](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) · [AWS Marketplace](https://aws.amazon.com/marketplace)
