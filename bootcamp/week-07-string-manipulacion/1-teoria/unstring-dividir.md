# UNSTRING — División de Cadenas

## 🎯 Objetivos

- Dividir una cadena en múltiples campos
- Usar DELIMITED BY con delimitadores simples y múltiples
- Contar ocurrencias con TALLYING
- Controlar la posición con POINTER
- Procesar líneas CSV completas

---

## 1. Sintaxis de UNSTRING

```cobol
       UNSTRING fuente
           DELIMITED BY [ALL] delimitador [OR [ALL] delimitador...]
           INTO destino-1 [DELIMITER IN delim-var-1]
                destino-2 [DELIMITER IN delim-var-2]
                ...
           [WITH POINTER variable]
           [TALLYING IN contador]
           [ON OVERFLOW sentencias...]
           [NOT ON OVERFLOW sentencias...]
       END-UNSTRING.
```

---

## 2. División Simple

```cobol
       01  WS-LINEA     PIC X(50) VALUE "Juan,Perez,35,Madrid".
       01  WS-NOMBRE    PIC X(20).
       01  WS-APELLIDO  PIC X(20).
       01  WS-EDAD      PIC X(05).
       01  WS-CIUDAD    PIC X(20).
       
           UNSTRING WS-LINEA
               DELIMITED BY ","
               INTO WS-NOMBRE
                    WS-APELLIDO
                    WS-EDAD
                    WS-CIUDAD.
      *> WS-NOMBRE   = "Juan"
      *> WS-APELLIDO = "Perez"
      *> WS-EDAD     = "35"
      *> WS-CIUDAD   = "Madrid"
```

---

## 3. DELIMITED BY ALL (Múltiples Caracteres Consecutivos)

`ALL` trata múltiples delimitadores consecutivos como uno solo:

```cobol
       01  WS-DATOS     PIC X(30) VALUE "Juan,,,Perez".
       
           UNSTRING WS-DATOS
               DELIMITED BY ALL ","
               INTO WS-CAMPO1 WS-CAMPO2.
      *> WS-CAMPO1 = "Juan"
      *> WS-CAMPO2 = "Perez"
      *> Las comas múltiples se tratan como una
```

---

## 4. DELIMITED BY con Múltiples Delimitadores

```cobol
       01  WS-TEXTO     PIC X(40) VALUE "Juan;Perez|35".
       
           UNSTRING WS-TEXTO
               DELIMITED BY ";" OR "|"
               INTO WS-CAMPO1 WS-CAMPO2 WS-CAMPO3.
      *> WS-CAMPO1 = "Juan"
      *> WS-CAMPO2 = "Perez"
      *> WS-CAMPO3 = "35"
```

---

## 5. DELIMITER IN — Capturar el Delimitador

Guarda el delimitador que se encontró:

```cobol
       01  WS-CSV       PIC X(50) VALUE "Juan,Perez,35".
       01  WS-DELIM1    PIC X(01).
       01  WS-DELIM2    PIC X(01).
       
           UNSTRING WS-CSV
               DELIMITED BY ","
               INTO WS-NOMBRE   DELIMITER IN WS-DELIM1
                    WS-APELLIDO DELIMITER IN WS-DELIM2
                    WS-EDAD.
      *> WS-DELIM1 = ","  (coma encontrada)
      *> WS-DELIM2 = ","  (coma encontrada)
      *> Si es el último campo, DELIMITER = espacios
```

---

## 6. TALLYING IN — Contar Campos Extraídos

```cobol
       01  WS-COUNT     PIC 9(03) VALUE ZEROS.
       
           UNSTRING WS-LINEA
               DELIMITED BY "," OR SPACE
               INTO WS-CAMPO1 WS-CAMPO2 WS-CAMPO3 WS-CAMPO4
               TALLYING IN WS-COUNT.
      *> WS-COUNT = número de campos realmente extraídos
       
           DISPLAY "Campos extraidos: " WS-COUNT.
```

---

## 7. POINTER — Continuar desde Posición

```cobol
       01  WS-PTR       PIC 9(03) USAGE COMP VALUE 1.
       01  WS-RESTO     PIC X(50).
       
           UNSTRING WS-LINEA
               DELIMITED BY ","
               INTO WS-NOMBRE WS-APELLIDO
               WITH POINTER WS-PTR.
      *> WS-PTR ahora apunta después del segundo campo
       
           UNSTRING WS-LINEA
               DELIMITED BY ","
               INTO WS-EDAD WS-CIUDAD
               WITH POINTER WS-PTR.
```

---

## 8. ON OVERFLOW — Más Campos que Destinos

```cobol
           UNSTRING WS-LINEA
               DELIMITED BY ","
               INTO WS-CAMPO1 WS-CAMPO2
               ON OVERFLOW
                   DISPLAY "WARNING: Mas campos de los esperados"
           END-UNSTRING.
```

---

## 9. Ejemplo: Parseo CSV Completo

```cobol
       01  WS-CSV-LINE   PIC X(80).
       01  WS-CLI-ID     PIC X(05).
       01  WS-CLI-NOMBRE PIC X(30).
       01  WS-CLI-SALDO  PIC X(10).
       01  WS-CLI-TIPO   PIC X(02).
       
           UNSTRING WS-CSV-LINE
               DELIMITED BY "," OR SPACE
               INTO WS-CLI-ID
                    WS-CLI-NOMBRE
                    WS-CLI-SALDO
                    WS-CLI-TIPO
               ON OVERFLOW
                   DISPLAY "Linea con mas campos de lo esperado"
           END-UNSTRING.
       
      *> Luego mover los campos PIC X a campos PIC 9
           COMPUTE WS-ID-NUM = FUNCTION NUMVAL(WS-CLI-ID).
```

---

## ✅ Checklist

- [ ] Dividir cadena con UNSTRING DELIMITED BY
- [ ] Usar ALL para múltiples delimitadores consecutivos
- [ ] Contar campos extraídos con TALLYING IN
- [ ] Capturar delimitador con DELIMITER IN
- [ ] Procesar CSV con UNSTRING
- [ ] Manejar OVERFLOW para campos extra

## 📚 Recursos

- [IBM COBOL UNSTRING Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-unstring-statement)
- [GnuCOBOL UNSTRING](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#UNSTRING)
