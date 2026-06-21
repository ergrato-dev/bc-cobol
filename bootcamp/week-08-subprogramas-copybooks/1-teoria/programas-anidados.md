# Programas Anidados — CONTAINS y Scope

## 🎯 Objetivos

- Definir programas anidados con CONTAINS
- Comprender el alcance (scope) de variables
- Compartir datos entre programa principal y anidados
- Usar COMMON PROGRAM para acceso global

---

## 1. CONTAINS — Programa Dentro de Programa

A diferencia de CALL (programas separados), CONTAINS define subprogramas **dentro del mismo archivo fuente**:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRINCIPAL.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-TOTAL    PIC 9(05) VALUE ZEROS.
       
       PROCEDURE DIVISION.
           PERFORM 1000-MOSTRAR.
           CALL "SUB-INTERNO".
           PERFORM 1000-MOSTRAR.
           STOP RUN.
       
       1000-MOSTRAR.
           DISPLAY "Total: " WS-TOTAL.
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUB-INTERNO.
       
       PROCEDURE DIVISION.
           ADD 100 TO WS-TOTAL.       *> ¡Accede a WS-TOTAL del padre!
           EXIT PROGRAM.
       
       END PROGRAM SUB-INTERNO.
       
       END PROGRAM PRINCIPAL.
```

> 📝 Cada programa anidado termina con `END PROGRAM nombre.`. El principal también.

---

## 2. Scope de Variables

Los programas anidados pueden ver las variables de sus ancestros:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PADRE.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PADRE    PIC X(10) VALUE "PADRE".
       
       PROCEDURE DIVISION.
           CALL "HIJO".
           STOP RUN.
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HIJO.
       
       PROCEDURE DIVISION.
           DISPLAY "Veo: " WS-PADRE.       *> ✅ Accede a variable del padre
           EXIT PROGRAM.
       
       END PROGRAM HIJO.
       END PROGRAM PADRE.
```

---

## 3. COMMON PROGRAM — Acceso desde Hermanos

COMMON permite que programas del mismo nivel se vean entre sí:

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PADRE.
       
           CALL "HIJO-1".
           STOP RUN.
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HIJO-1.
       
           CALL "HIJO-2".              *> ✅ Puede llamar a HIJO-2
           EXIT PROGRAM.
       
       END PROGRAM HIJO-1.
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HIJO-2 IS COMMON.   *> Declarado COMMON
       
           DISPLAY "Hola desde HIJO-2".
       
       END PROGRAM HIJO-2.
       END PROGRAM PADRE.
```

---

## 4. CALL vs CONTAINS

| Característica | CALL (externo) | CONTAINS (anidado) |
|---------------|---------------|-------------------|
| Archivos | Separados | Mismo archivo |
| Compilación | Juntos o separados | Siempre juntos |
| Scope datos | Solo LINKAGE | Ve WORKING-STORAGE del padre |
| Parámetros | Obligatorios (USING) | No necesita (comparte) |
| Reutilización | Alta (múltiples programas) | Baja (solo dentro del padre) |
| Uso típico | Librerías, utilidades | Lógica interna del programa |

---

## 5. Cuándo Usar Cada Uno

### CALL (externo)

```cobol
      *> Utilidades reutilizables por muchos programas
       CALL "VALIDAR-FECHA" USING WS-FECHA WS-OK.
       CALL "FORMATEAR-MONTO" USING WS-MONTO WS-EDIT.
```

### CONTAINS (anidado)

```cobol
      *> Lógica interna que solo usa este programa
       CALL "INICIALIZAR-TABLAS"       *> Sin parámetros, comparte memoria
       CALL "PROCESAR-REGISTRO"        *> Idem
```

---

## ✅ Checklist

- [ ] Definir programa anidado con IDENTIFICATION DIVISION dentro de otro
- [ ] Usar END PROGRAM para cerrar cada programa
- [ ] Acceder a variables del padre desde el programa anidado
- [ ] Diferenciar CALL (externo) de CONTAINS (anidado)
- [ ] Usar COMMON para visibilidad entre hermanos

## 📚 Recursos

- [IBM COBOL Nested Programs](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=structure-nested-programs)
- [GnuCOBOL CONTAINS](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#CONTAINS)
