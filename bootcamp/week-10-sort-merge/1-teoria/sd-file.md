# SD File — Sort Description

## 🎯 Objetivos

- Declarar archivos de sort con SD
- Diferenciar FD (File Description) de SD (Sort Description)
- Configurar el layout del registro de sort
- Entender archivos temporales de ordenamiento

---

## 1. ¿Qué es SD?

SD (Sort Description) describe un archivo temporal usado exclusivamente por SORT. Es similar a FD pero para archivos de trabajo interno.

```cobol
       DATA DIVISION.
       FILE SECTION.
       
      *> FD: archivo de datos normal
       FD  ENTRADA.
       01  ENT-REG    PIC X(80).
       
      *> SD: archivo temporal de sort
       SD  SORT-WORK.
       01  SORT-REG.
           05 SORT-ID     PIC 9(05).
           05 SORT-NOMBRE PIC X(30).
           05 SORT-SALDO  PIC 9(07)V99.
```

---

## 2. FD vs SD

| Característica | FD | SD |
|---------------|-----|-----|
| Propósito | Datos persistentes | Temporal para SORT |
| Persistent? | ✅ Sí | ❌ Se elimina al terminar |
| OPEN/CLOSE | ✅ Manual | ❌ Automático (SORT lo maneja) |
| SELECT | ✅ Requerido | ✅ Requerido |
| ORGANIZATION | ✅ Configurable | Normalmente SEQUENTIAL |
| READ/WRITE | ✅ Manual | ❌ Solo vía SORT/MERGE |

---

## 3. SELECT para Archivo SD

```cobol
       FILE-CONTROL.
           SELECT ENTRADA  ASSIGN TO "datos.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SALIDA   ASSIGN TO "ordenado.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SORT-WK  ASSIGN TO "sortwork.tmp".   *> Archivo temporal
```

El archivo temporal se crea y elimina automáticamente. No necesitas preocuparte por su contenido.

---

## 4. Layout del SD

El layout del SD debe coincidir con los datos a ordenar:

```cobol
       FD  ENTRADA.
       01  ENT-REG.
           05 ENT-ID       PIC 9(05).
           05 ENT-NOMBRE   PIC X(30).
           05 ENT-SALDO    PIC 9(07)V99.
       
       SD  SORT-WK.
       01  SORT-REG.
           05 SORT-ID      PIC 9(05).    *> Mismo layout que ENT-REG
           05 SORT-NOMBRE  PIC X(30).
           05 SORT-SALDO   PIC 9(07)V99.
       
      *> También funciona con un solo campo si no necesitas las claves individuales
       SD  SORT-WK-2.
       01  SORT-REG-2      PIC X(39).    *> Layout genérico
```

---

## 5. Claves de SORT

Las claves en ASCENDING/DESCENDING KEY deben ser campos del registro SD:

```cobol
       SD  SORT-WK.
       01  SORT-REG.
           05 SORT-SUC     PIC 9(03).    *> Se puede usar como clave
           05 SORT-TIPO    PIC X(02).    *> Se puede usar como clave
           05 SORT-MONTO   PIC 9(07)V99.*> Se puede usar como clave
       
       PROCEDURE DIVISION.
           SORT SORT-WK
               ASCENDING KEY SORT-SUC
               ASCENDING KEY SORT-TIPO
               DESCENDING KEY SORT-MONTO
               USING ENTRADA GIVING SALIDA.
```

---

## 6. Múltiples Archivos SD

Puedes declarar varios SD si necesitas múltiples sorts:

```cobol
       FILE SECTION.
       SD  SORT-PRIMARIO.
       01  SORT1-REG  PIC X(80).
       
       SD  SORT-SECUNDARIO.
       01  SORT2-REG.
           05 S2-CLAVE  PIC 9(05).
           05 FILLER    PIC X(75).
```

---

## ✅ Checklist

- [ ] Declarar SD con SELECT en FILE-CONTROL
- [ ] Diseñar layout del SD con los campos a ordenar
- [ ] Usar campos del SD como claves en ASCENDING/DESCENDING KEY
- [ ] Entender que el archivo SD es temporal (no se conserva)

## 📚 Recursos

- [IBM COBOL SD (Sort Description)](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-sort-file-description)
- [GnuCOBOL SD](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#SD)
