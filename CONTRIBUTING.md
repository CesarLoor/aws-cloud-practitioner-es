# Cómo contribuir

¡Gracias por querer mejorar esta guía! La idea es que cualquier persona que estudie para el AWS Certified Cloud Practitioner encuentre aquí todo claro: teoría, ejemplos, casos, laboratorios, preguntas y diagramas. **No necesitas instalar nada** para aportar.

## Formas de aportar

| Quiero… | Cómo |
| --- | --- |
| Reportar un error o algo confuso | Abre un [issue](https://github.com/CesarLoor/aws-cloud-practitioner-es/issues/new/choose) con la página y lo que viste |
| Corregir o mejorar un texto | En el sitio, pulsa el **lápiz** (editar) de la página. GitHub te guía para crear un *pull request* desde el navegador |
| Agregar capturas de la consola | Sigue las reglas de capturas de abajo y súbelas en un *pull request* |
| Proponer preguntas, casos o laboratorios | Abre un issue de sugerencia o envía el *pull request* directamente |

Nadie puede publicar directamente en la rama principal: todo aporte llega como *pull request* y **solo el mantenedor del proyecto lo aprueba y lo incorpora**. Además, cada *pull request* se revisa automáticamente: se compila el sitio en modo estricto (detecta enlaces e imágenes rotos), se valida la plantilla de CloudFormation y se revisa la sintaxis de los scripts. Si algo falla, el mismo *pull request* te dirá qué.

## Reglas de contenido

- **Español neutro**, frases cortas y claras. Los nombres de los servicios van en su forma oficial en inglés (Amazon EC2, AWS Lambda).
- **Redacción propia.** No copies texto, preguntas, capturas ni videos del curso de AWS Skill Builder ni de exámenes oficiales. Explica con tus palabras y enlaza la fuente oficial.
- **Fuentes oficiales.** Para datos que cambian (precios, capa gratuita, límites), enlaza la documentación de AWS.
- **Completo.** Cada lección debe tener: objetivos, teoría, ejemplos o casos, notas rápidas, preguntas para comprobar lo aprendido y enlaces para profundizar.

## Capturas de pantalla

Estamos agregando capturas propias para que las guías y los laboratorios se entiendan mejor. Si aportas una:

1. Tómala de **tu propia consola** de AWS (no de videos ni del curso).
2. **Oculta los datos sensibles:** ID de cuenta, correos, nombres de usuario, direcciones IP públicas, ARN y claves. Difumínalos o cúbrelos antes de subirla.
3. Formato **PNG**, de unos **1600 px** de ancho, con la consola en idioma español si es posible.
4. Guárdala en `docs/img/mX/` (X = número de módulo) con un nombre descriptivo, por ejemplo `m2-lab-lanzar-instancia.png`.
5. Insértala con su pie de foto:

    ```html
    <figure markdown="span">
      ![Asistente de lanzamiento de EC2](../img/m2/m2-lab-lanzar-instancia.png)
      <figcaption>Sección de red del asistente de lanzamiento.</figcaption>
    </figure>
    ```

## Diagramas

Usa los [AWS Architecture Icons](https://aws.amazon.com/architecture/icons/) oficiales, sin modificarlos, y respeta los colores de los grupos (VPC, subred pública, subred privada). Guarda el diagrama como PNG en `docs/img/mX/`.

## Laboratorios

- Indica **costo, tiempo y servicios** al inicio.
- Incluye una tabla de **valores a usar**, el **paso a paso**, las **pruebas de verificación**, los **errores comunes** y la **limpieza verificada**.
- Los scripts van en `labs/modulo-XX/`. Los scripts de verificación **solo consultan**: nunca crean ni borran recursos.
- Prefiere us-east-1 y recursos de la capa gratuita. Si algo cobra por hora (NAT Gateway, balanceadores), avísalo con un recuadro de peligro.

## Estructura del repositorio

```
docs/            Páginas del sitio (Markdown) e imágenes (docs/img)
labs/            Scripts y plantillas de los laboratorios
overrides/       Personalización del tema (aviso superior)
mkdocs.yml       Configuración y menú del sitio
```

Si agregas una página nueva, añádela también al menú (`nav`) de `mkdocs.yml`.

## Licencia

Al contribuir aceptas que tu aporte se publique bajo [CC BY-SA 4.0](LICENSE) (contenido) o [MIT](LICENSE-CODE) (scripts y plantillas).
