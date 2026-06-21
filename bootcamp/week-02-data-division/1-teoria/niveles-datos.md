# Niveles de Datos: 01-49, 77, 88

## 🎯 Objetivos

- Comprender la jerarquía de datos COBOL (01 → 49)
- Declarar variables independientes con nivel 77
- Crear condiciones declarativas con nivel 88 (condition names)

---

## 1. Jerarquía de Datos

COBOL organiza los datos en **niveles jerárquicos** del 01 al 49. Es como un árbol: el nivel 01 es la raíz, los niveles 02-49 son ramas y hojas.

```
01  CLIENTE              ← Nivel 01: registro completo (raíz)
    05  ID               ← Nivel 05: subgrupo/elemento
    05  NOMBRE           ← Nivel 05: subgrupo
        10 PRIMER-NOMBRE ← Nivel 10: elemento atómico
        10 APELLIDO      ← Nivel 10: elemento atómico
    05  DIRECCION        ← Nivel 05: subgrupo
        10 CALLE         ← Nivel 10: elemento
        10 CIUDAD        ← Nivel 10: elemento
    05  SALDO            ← Nivel 05: elemento atómico
```

### Reglas

1. El **número de nivel no importa**, solo la **relación jerárquica**
2. Un nivel menor **contiene** a los niveles mayores que le siguen
3. Niveles estándar: 01, 05, 10, 15, 20... (incremento de 5 por convención)
4. Un elemento sin subordinados es **elemental** (tiene PIC)
5. Un elemento con subordinados es **grupo** (no tiene PIC)

---

## 2. Niveles 01 a 49

```cobol
       WORKING-STORAGE SECTION.
       
      *> Nivel 01: registro completo (grupo)
       01  REG-FACTURA.
      *>     Nivel 05: encabezado (subgrupo)
           05  FAC-ENCABEZADO.
               10 FAC-NUMERO       PIC 9(08).
               10 FAC-FECHA.
                   15 FAC-ANO      PIC 9(04).
                   15 FAC-MES      PIC 9(02).
                   15 FAC-DIA      PIC 9(02).
      *>     Nivel 05: cliente (subgrupo)
           05  FAC-CLIENTE.
               10 FAC-CLI-ID      PIC 9(05).
               10 FAC-CLI-NOMBRE  PIC X(40).
      *>     Nivel 05: detalle (elemental simple)
           05  FAC-TOTAL          PIC S9(09)V99.
```

### Elemental vs Grupo

```cobol
      *> GRUPO: no tiene PIC, agrupa otros elementos
       01  FECHA.
           05 ANO   PIC 9(04).     *> ELEMENTAL: tiene PIC
           05 MES   PIC 9(02).     *> ELEMENTAL: tiene PIC
           05 DIA   PIC 9(02).     *> ELEMENTAL: tiene PIC
       
      *> MOVE a nivel de grupo mueve todos los subordinados
           MOVE "20260620" TO FECHA.
      *> ANO = 2026, MES = 06, DIA = 20
```

---

## 3. Nivel 77 — Variables Independientes

El nivel 77 define variables **elementales independientes** que no pertenecen a ningún grupo. Es equivalente a declarar una variable suelta.

```cobol
       WORKING-STORAGE SECTION.
       77  WS-CONTADOR     PIC 9(05) VALUE ZEROS.
       77  WS-TASA-INTERES PIC 9V99  VALUE 3.50.
       77  WS-MENSAJE      PIC X(60) VALUE SPACES.
```

### Reglas del nivel 77

- ✅ Debe ser **elemental** (siempre tiene PIC)
- ✅ Debe aparecer **antes** de cualquier nivel 01
- ✅ No puede tener subordinados
- ✅ No se puede calificar (acceder vía grupo)

```cobol
      *> ✅ CORRECTO: 77 antes de 01
       77  WS-TASA    PIC 9V99 VALUE 3.50.
       
       01  WS-REGISTRO.
           05 WS-CAMPO1 PIC X(10).
       
      *> ❌ INCORRECTO: 77 después de 01
      *01  WS-REGISTRO...
      *77  WS-TASA...
```

> 📝 En la práctica, muchos programadores prefieren usar `01` para todo y evitar `77`. En GnuCOBOL con formato libre, puedes usar `01` para variables elementales también.

---

## 4. Nivel 88 — Condition Names

El nivel 88 es una **condición booleana declarativa**. No ocupa espacio en memoria. Se asocia a una variable y define valores que representan estados.

```cobol
       01  WS-ESTADO-CUENTA    PIC X(01).
           88 CUENTA-ACTIVA    VALUE "A".
           88 CUENTA-INACTIVA  VALUE "I".
           88 CUENTA-BLOQUEADA VALUE "B".
           88 CUENTA-CERRADA   VALUE "C".
```

### Uso de 88-level

```cobol
      *> Asignar valor
           SET CUENTA-ACTIVA TO TRUE.
      *> Equivalente a: MOVE "A" TO WS-ESTADO-CUENTA
       
      *> Verificar condición (más legible)
           IF CUENTA-ACTIVA
               DISPLAY "La cuenta esta activa"
           END-IF.
      *> Equivalente a: IF WS-ESTADO-CUENTA = "A"
```

### 88 con rangos y múltiples valores

```cobol
       01  WS-EDAD              PIC 9(03).
           88 ES-MENOR          VALUE 0 THRU 17.
           88 ES-ADULTO         VALUE 18 THRU 64.
           88 ES-JUBILADO       VALUE 65 THRU 999.
       
       01  WS-TIPO-TRANSACCION  PIC X(01).
           88 TRANSACCION-VALIDA VALUE "D" "R" "T" "C".
           88 ES-DEPOSITO        VALUE "D".
           88 ES-RETIRO          VALUE "R".
           88 ES-TRANSFERENCIA   VALUE "T".
           88 ES-CONSULTA        VALUE "C".
       
       01  WS-CODIGO-RESPUESTA  PIC 9(02).
           88 RESPUESTA-OK      VALUE 0.
           88 RESPUESTA-ERROR   VALUE 1 THRU 99.
```

### Ventajas de 88-level

- ✅ Código **auto-documentado** (se lee como español/inglés)
- ✅ Fácil de **mantener** (cambias el VALUE en un solo lugar)
- ✅ **Sin costo** de memoria (no ocupa espacio)
- ✅ Funciona con **IF**, **EVALUATE**, **PERFORM UNTIL**

---

## 5. FILLER — Campos sin Nombre

`FILLER` define espacio reservado sin nombre explícito. Útil para padding y alineación.

```cobol
       01  WS-CABECERA.
           05 FILLER PIC X(10) VALUE SPACES.    *> Padding izquierdo
           05 WS-TITULO PIC X(30) VALUE "REPORTE DE CUENTAS".
           05 FILLER PIC X(10) VALUE SPACES.    *> Padding derecho
       
      *> Muestra: "          REPORTE DE CUENTAS          "
```

> 📝 En GnuCOBOL puedes acceder a FILLER por su posición, pero en general no debes referenciarlo directamente.

---

## 6. REDEFINES — Reinterpretación de Memoria

`REDEFINES` permite que dos estructuras **compartan la misma memoria**. Útil para dar diferentes interpretaciones de los mismos bytes.

```cobol
       01  WS-BUFFER            PIC X(80).
       01  WS-REG-CLIENTE REDEFINES WS-BUFFER.
           05 WS-CLI-ID         PIC 9(05).
           05 WS-CLI-NOMBRE     PIC X(30).
           05 WS-CLI-SALDO      PIC 9(07)V99.
           05 FILLER            PIC X(36).
```

Ambos `WS-BUFFER` y `WS-REG-CLIENTE` ocupan los mismos 80 bytes. Al modificar uno, cambias el otro.

---

## ✅ Checklist

- [ ] Diseñar una jerarquía de datos con al menos 3 niveles (01, 05, 10)
- [ ] Declarar variables independientes con nivel 77
- [ ] Crear condition names con nivel 88 para estados de cuenta
- [ ] Usar SET ... TO TRUE para asignar un 88-level
- [ ] Usar IF con 88-level para código más legible
- [ ] Usar FILLER para padding en un layout

## 📚 Recursos

- [IBM COBOL Data Division Structure](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=division-data-structure)
- [GnuCOBOL Level Numbers](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Level-numbers)
