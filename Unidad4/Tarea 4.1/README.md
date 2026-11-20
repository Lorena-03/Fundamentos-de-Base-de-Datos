# Mapa conceptual de normalización

```mermaid
flowchart TD
    N["`**NORMALIZACIÓN**
    Reduce redundancia y anomalías`"]

    N -->|Analiza| D
    N -->|Establece| FN
    N -->|Previene| A

    subgraph DEP["Dependencias"]
        direction TB
        D["DEPENDENCIAS"]

        DF["`**Funcional**
        X → Y
        X determina un único Y`"]

        DC["`**Completa**
        Depende de todo X
        Ninguna parte basta`"]

        DP["`**Parcial**
        Una parte de la clave
        ya determina el dato`"]

        DT["`**Transitiva**
        X → Y e Y → Z
        X determina Z mediante Y`"]

        DM["`**Multivaluada**
        X ↠ Y
        Conjuntos independientes`"]

        DR["`**De reunión**
        La relación se reconstruye
        al unir sus proyecciones`"]

        D -->|Incluyen| DF
        D --> DC
        D --> DP
        D --> DT
        D --> DM
        D --> DR

        DF ~~~ DC
        DC ~~~ DP
        DP ~~~ DT
        DT ~~~ DM
        DM ~~~ DR
    end

    subgraph FORMAS["Formas normales"]
        direction TB
        FN["FORMAS NORMALES"]

        F1["`**1FN**
        Valores atómicos
        Sin listas ni grupos repetidos`"]

        F2["`**2FN**
        Cumple 1FN
        Sin dependencias parciales de atributos
        no primos respecto de claves candidatas`"]

        F3["`**3FN**
        Cumple 2FN
        Para cada X → A no trivial
        X es superclave o A es primo`"]

        BC["`**FNBC**
        En cada dependencia funcional no trivial
        el determinante es una superclave`"]

        F4["`**4FN**
        En cada dependencia multivaluada no trivial
        el determinante es una superclave`"]

        F5["`**5FN**
        Toda dependencia de reunión no trivial
        válida se deduce de las claves candidatas`"]

        FN -->|Exige| F1
        F1 -->|Y además| F2
        F2 -->|Y además| F3
        F3 -->|Y además| BC
        BC -->|Y además| F4
        F4 -->|Y además| F5
    end

    subgraph ANOM["Anomalías y descomposición"]
        direction TB
        A["ANOMALÍAS"]

        AI["`**Inserción**
        No permite registrar
        un hecho por sí solo`"]

        AB["`**Borrado**
        Eliminar un hecho
        borra otro necesario`"]

        AM["`**Modificación**
        Actualizar copias
        produce inconsistencias`"]

        DES["`**DESCOMPOSICIÓN**
        Debe conservar la información
        sin crear filas falsas
        Se busca preservar las dependencias funcionales`"]

        A -->|Son| AI
        A --> AB
        A --> AM

        AI ~~~ AB
        AB ~~~ AM
        AM ~~~ DES
    end

    FN -->|Se alcanza mediante| DES

    classDef principal fill:#E5F1ED,stroke:#236C64,color:#172B3A,stroke-width:2px;
    classDef dependencia fill:#EEF5FA,stroke:#255D80,color:#172B3A;
    classDef normal fill:#EEF7F3,stroke:#236C64,color:#172B3A;
    classDef anomalia fill:#FFF7EE,stroke:#9B6A31,color:#172B3A;
    classDef descomposicion fill:#F3F5F6,stroke:#4F5C64,color:#172B3A;

    class N principal;
    class D,DF,DC,DP,DT,DM,DR dependencia;
    class FN,F1,F2,F3,BC,F4,F5 normal;
    class A,AI,AB,AM anomalia;
    class DES descomposicion;
```

## Conceptos de apoyo

- **Superclave:** conjunto de atributos que identifica de forma única cada tupla.
- **Clave candidata:** superclave mínima; ningún subconjunto propio conserva esa capacidad.
- **Atributo primo:** pertenece a alguna clave candidata.
- **Dependencia no trivial:** en una dependencia funcional X → Y, Y no está contenido en X.
