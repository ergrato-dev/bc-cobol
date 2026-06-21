# STRING — Concatenación de Cadenas

## 🎯 Objetivos

- Concatenar múltiples campos en una sola cadena
- Usar DELIMITED BY SIZE, SPACE y delimitador personalizado
- Controlar la posición con POINTER
- Manejar desbordamiento con OVERFLOW

---

## 1. Sintaxis de STRING

```cobol
       STRING fuente-1 DELIMITED BY [SIZE | SPACE | delimitador]
              fuente-2 DELIMITED BY [SIZE | SPACE | delimitador]
              ...
           INTO destino
           [WITH POINTER variable]
           [ON OVERFLOW sentencias...]
           [NOT ON OVERFLOW sentencias...]
       END-STRING.
```

---

## 2. DELIMITED BY SIZE (Todo el Campo)

Copia el campo completo (incluyendo espacios al final):

```cobol
       01  WS-NOMBRE    PIC X(10) VALUE "Juan".
       01  WS-APELLIDO  PIC X(10) VALUE "Perez".
       01  WS-COMPLETO  PIC X(30) VALUE SPACES.
       
           STRING WS-NOMBRE DELIMITED BY SIZE
                  " "     DELIMITED BY SIZE
                  WS-APELLIDO DELIMITED BY SIZE
                  INTO WS-COMPLETO.
      *> Resultado: "Juan      Perez          "
      *> ↑ Incluye los espacios de relleno de PIC X(10)
```

---

## 3. DELIMITED BY SPACE (Hasta el Primer Espacio)

Copia solo hasta encontrar un espacio (o fin del campo):

```cobol
           STRING WS-NOMBRE DELIMITED BY SPACE
                  " "     DELIMITED BY SIZE
                  WS-APELLIDO DELIMITED BY SPACE
                  INTO WS-COMPLETO.
      *> Resultado: "Juan Perez"
      *> ↑ Limpio, sin espacios de relleno
```

> 📝 Si el campo no tiene espacios (está lleno), DELIMITED BY SPACE copia todo el campo.

---

## 4. DELIMITED BY delimitador (Personalizado)

Copia hasta encontrar un carácter específico:

```cobol
       01  WS-DIRECCION  PIC X(50) VALUE "Calle 123, Ciudad, Pais".
       01  WS-CALLE      PIC X(30).
       01  WS-CIUDAD     PIC X(20).
       01  WS-RESTO      PIC X(30).
       
           UNSTRING WS-DIRECCION
               DELIMITED BY ","
               INTO WS-CALLE
                    WS-CIUDAD
                    WS-RESTO.
      *> WS-CALLE  = "Calle 123"
      *> WS-CIUDAD = " Ciudad"
      *> WS-RESTO  = " Pais"
```

> 📝 El delimitador **no** se copia en el destino.

---

## 5. POINTER — Control de Posición

Permite concatenar en una posición específica:

```cobol
       01  WS-PTR      PIC 9(03) USAGE COMP VALUE 1.
       01  WS-RESULT   PIC X(40) VALUE SPACES.
       
           STRING "ID:" DELIMITED BY SIZE
                  WS-ID  DELIMITED BY SIZE
                  INTO WS-RESULT
                  WITH POINTER WS-PTR.
      *> WS-PTR ahora = 9 (siguiente posición libre)
       
           STRING " - " DELIMITED BY SIZE
                  WS-NOMBRE DELIMITED BY SPACE
                  INTO WS-RESULT
                  WITH POINTER WS-PTR.
      *> Resultado: "ID:00104 - Juan Perez"
```

---

## 6. ON OVERFLOW — Manejo de Desbordamiento

Si el destino no tiene suficiente espacio:

```cobol
           STRING WS-TEXTO-LARGO DELIMITED BY SIZE
                  INTO WS-CAMPO-CHICO
               ON OVERFLOW
                   DISPLAY "ERROR: Texto truncado"
               NOT ON OVERFLOW
                   DISPLAY "Concatenacion exitosa"
           END-STRING.
```

---

## 7. Ejemplos Prácticos

### Construir nombre completo

```cobol
           STRING WS-PRIMER-NOMBRE DELIMITED BY "  "
                  " "                DELIMITED BY SIZE
                  WS-APELLIDO        DELIMITED BY "  "
                  INTO WS-NOMBRE-COMPLETO.
```

### Construir línea de reporte

```cobol
           STRING "| "  DELIMITED BY SIZE
                  WS-ID  DELIMITED BY SIZE
                  " | "  DELIMITED BY SIZE
                  WS-NOMBRE DELIMITED BY SPACE
                  " | "  DELIMITED BY SIZE
                  WS-SALDO-EDIT DELIMITED BY SIZE
                  " |"   DELIMITED BY SIZE
                  INTO WS-LINEA-REPORTE.
      *> | 00104 | Juan | $ 15,000.50 |
```

### Construir ruta de archivo

```cobol
           STRING WS-DIRECTORIO DELIMITED BY SPACE
                  "/"           DELIMITED BY SIZE
                  WS-ARCHIVO    DELIMITED BY SPACE
                  INTO WS-RUTA-COMPLETA.
      *> data/clientes.dat
```

---

## ✅ Checklist

- [ ] Concatenar campos con STRING DELIMITED BY SIZE
- [ ] Eliminar espacios con DELIMITED BY SPACE
- [ ] Usar POINTER para concatenar en múltiples pasos
- [ ] Manejar OVERFLOW para evitar truncamiento silencioso
- [ ] Construir líneas de reporte con STRING

## 📚 Recursos

- [IBM COBOL STRING Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-string-statement)
- [GnuCOBOL STRING](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#STRING)
