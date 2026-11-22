# AWS Cloud Practitioner en español

Guía de estudio abierta para la certificación **AWS Certified Cloud Practitioner (CLF-C02)**, organizada como una asignatura: lecciones con explicación, diagramas con los iconos oficiales de AWS, casos de uso, notas rápidas, laboratorios con scripts de verificación y evaluaciones con respuestas explicadas.

**Lee la guía en: https://cesarloor.github.io/aws-cloud-practitioner-es/**

## Contenido

| Sección | Estado |
| --- | --- |
| Entorno de práctica: cuenta, consola, configuración base, limpieza y documentación | ✅ |
| Módulo 1 · Introducción a la nube (4 lecciones + laboratorio + evaluación) | ✅ |
| Módulos 2 a 5 | 🔜 Próximamente |
| Módulos 6 a 13 | ⏳ Pendiente |

## Estructura del repositorio

```
docs/        Páginas del sitio (Markdown) e imágenes
labs/        Scripts y plantillas de CloudFormation de los laboratorios
mkdocs.yml   Configuración del sitio (MkDocs Material)
```

## Ver el sitio en tu computadora

```bash
pip install -r requirements.txt
mkdocs serve
```

Abre http://127.0.0.1:8000. Cada cambio en `docs/` se recarga solo.

## Contribuir

Las correcciones, aclaraciones y casos de uso nuevos son bienvenidos: abre un *issue* o un *pull request*. Antes de enviar cambios, comprueba que `mkdocs build --strict` termina sin errores.

## Licencia y avisos

- El contenido (textos y diagramas) se publica bajo [CC BY-SA 4.0](LICENSE). Los scripts y plantillas de `labs/`, bajo [MIT](LICENSE-CODE).
- Proyecto comunitario, **no afiliado a Amazon Web Services**. AWS y los nombres de sus servicios son marcas de Amazon.com, Inc. o sus filiales. Los diagramas usan los [AWS Architecture Icons](https://aws.amazon.com/architecture/icons/) según sus condiciones de uso.
- Las condiciones de la capa gratuita y los precios cambian: confírmalos en las páginas oficiales de AWS antes de cada laboratorio.
