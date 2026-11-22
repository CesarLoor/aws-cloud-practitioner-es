# 2.2 Tipos de instancias de Amazon EC2

!!! abstract "En esta lección aprenderás a"
    Explicar los distintos tipos de instancias de EC2 y sus características · identificar el caso de uso apropiado para cada uno · leer el nombre de un tipo de instancia.

## 1. Familias y tipos

Amazon EC2 ofrece muchos **tipos de instancia**, cada uno con una combinación distinta de **CPU, memoria, almacenamiento y red**. Los tipos se agrupan en **familias** según para qué están optimizados. Elegir bien la familia te da el rendimiento que necesitas sin pagar de más.

| Familia | Qué prioriza | Prefijos de ejemplo | Casos de uso |
| --- | --- | --- | --- |
| **Uso general** | Equilibrio entre cómputo, memoria y red. Buen **punto de partida**. | T (con ráfagas), M | Servidores web, repositorios de código, aplicaciones pequeñas y medianas, cargas cuyo rendimiento es incierto |
| **Optimizadas para cómputo** | Procesadores de alto rendimiento | C | Servidores de juegos, computación de alto rendimiento (HPC), machine learning, modelado científico, procesamiento por lotes |
| **Optimizadas para memoria** | Mucha RAM y acceso rápido en memoria | R, X, z | Bases de datos, procesamiento de grandes conjuntos de datos en memoria, analítica en tiempo real |
| **Computación acelerada** | Aceleradores de hardware: GPU u otros chips | P, G, Inf, Trn | Cálculos de punto flotante, procesamiento de gráficos, coincidencia de patrones de datos, entrenamiento e inferencia de machine learning |
| **Optimizadas para almacenamiento** | Alto rendimiento de lectura y escritura en discos locales | I, D, H | Bases de datos de gran tamaño, data warehouses, aplicaciones con uso intensivo de E/S |

!!! tip "Truco para recordarlas"
    *General* para empezar, *C* de **C**PU, *R* de **R**AM, *P/G* de **G**PU e *I* de **I**/O (entrada/salida).

## 2. Cómo se lee el nombre de un tipo de instancia

Ejemplo: **`m7g.xlarge`**

| Parte | Valor | Significado |
| --- | --- | --- |
| Familia | `m` | Uso general |
| Generación | `7` | Séptima generación (más alta = más nueva y suele ser más eficiente) |
| Atributos | `g` | Procesador AWS Graviton (ARM). Otros: `i` Intel, `a` AMD, `d` disco NVMe local, `n` red mejorada |
| Tamaño | `xlarge` | Cantidad de recursos: nano, micro, small, medium, large, xlarge, 2xlarge… Cada tamaño suele duplicar al anterior |

Referencia oficial: [convenciones de nombres de los tipos de instancia](https://docs.aws.amazon.com/ec2/latest/instancetypes/instance-type-names.html).

## 3. Cómo elegir el tipo correcto

1. **Empieza por uso general** si no conoces bien tu carga.
2. **Mide** el uso real de CPU, memoria y red (con Amazon CloudWatch).
3. **Ajusta:** si la CPU está siempre alta, pasa a optimizada para cómputo; si falta memoria, a optimizada para memoria.
4. **Cambia de tipo cuando lo necesites:** en instancias con disco EBS basta con detenerla, cambiar el tipo e iniciarla de nuevo.
5. **Busca el equilibrio entre rendimiento y presupuesto:** paga solo por lo que vas a usar. **AWS Compute Optimizer** te recomienda el tamaño adecuado a partir de tu uso real.

## 4. Ejemplos

| Escenario | Familia recomendada |
| --- | --- |
| Blog corporativo con tráfico moderado | Uso general (T o M) |
| Servidor de un videojuego en línea | Optimizada para cómputo (C) |
| Base de datos en memoria con cientos de GB | Optimizada para memoria (R o X) |
| Entrenamiento de un modelo de IA | Computación acelerada (P o Trn) |
| Data warehouse con lecturas masivas en disco local | Optimizada para almacenamiento (I o D) |

!!! example "Pruébalo en CloudShell"
    ```bash
    # Características de un tipo de instancia
    aws ec2 describe-instance-types --instance-types m7g.xlarge \
      --query "InstanceTypes[].[InstanceType,VCpuInfo.DefaultVCpus,MemoryInfo.SizeInMiB,ProcessorInfo.SupportedArchitectures[0]]" \
      --output table
    ```

## Comprueba lo aprendido

**1.** ¿Qué familia elegirías para un servidor de juegos?

**2.** ¿Qué indica la letra `g` en `c7g.large`?

**3.** Tu instancia nunca pasa del 5 % de CPU. ¿Qué deberías hacer?

??? success "Ver respuestas"
    1. **Optimizada para cómputo.**
    2. Que usa procesadores **AWS Graviton**.
    3. **Reducir el tamaño** (rightsizing) para pagar menos.

## Para profundizar

- [Tipos de instancias de Amazon EC2](https://aws.amazon.com/ec2/instance-types/)
- [AWS Compute Optimizer](https://aws.amazon.com/compute-optimizer/)
