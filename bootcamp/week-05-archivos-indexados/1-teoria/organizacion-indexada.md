# Organización Indexada — INDEXED Files

## 🎯 Objetivos

- Configurar archivos con ORGANIZATION IS INDEXED
- Comprender la estructura interna de un archivo indexado
- Crear y poblar archivos indexados desde cero

---

## 1. ¿Qué es un Archivo Indexado?

Un archivo indexado permite acceder a registros por **clave** (key), como una tabla de base de datos. Combina acceso secuencial y acceso directo.

```cobol
       SELECT PRODUCTOS
           ASSIGN TO "productos.idx"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS PROD-ID
           FILE STATUS IS WS-FS-PROD.
```

### Comparación con Secuencial

| Característica | Secuencial | Indexado |
|---------------|-----------|----------|
| Acceso por clave | ❌ No | ✅ Sí |
| Acceso secuencial | ✅ Sí | ✅ Sí |
| Velocidad búsqueda | O(n) | O(log n) |
| Tamaño archivo | Más chico | Más grande (índices) |
| Complejidad | Simple | Media |
| Uso típico | Logs, reportes | Maestros, catálogos |

---

## 2. Archivos del Sistema

GnuCOBOL usa múltiples archivos físicos para un archivo indexado:

```
productos.idx        ← Archivo de datos (registros)
productos.idx.idx    ← Archivo de índice primario
```

> 📝 No manipules los archivos `.idx` manualmente. Siempre usa el programa COBOL.

---

## 3. Crear un Archivo Indexado

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CREAIDX.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRODUCTOS
               ASSIGN TO "productos.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS SEQUENTIAL
               RECORD KEY IS PROD-ID
               FILE STATUS IS WS-FS-PROD.
       
       DATA DIVISION.
       FILE SECTION.
       FD  PRODUCTOS.
       01  PROD-REG.
           05 PROD-ID        PIC 9(05).
           05 PROD-NOMBRE    PIC X(30).
           05 PROD-PRECIO    PIC 9(07)V99.
       
       WORKING-STORAGE SECTION.
       01  WS-FS-PROD        PIC X(02).
           88 PROD-OK        VALUE "00".
           88 PROD-DUP       VALUE "22".  *> Clave duplicada
```

### Poblar el archivo

```cobol
       PROCEDURE DIVISION.
       MAIN.
           OPEN OUTPUT PRODUCTOS.       *> OUTPUT crea archivo nuevo
           
           MOVE 101 TO PROD-ID.
           MOVE "Cuenta Corriente Basica" TO PROD-NOMBRE.
           MOVE 0 TO PROD-PRECIO.
           WRITE PROD-REG.
           IF PROD-DUP
               DISPLAY "ID duplicado: " PROD-ID
           END-IF.
           
           MOVE 102 TO PROD-ID.
           MOVE "Tarjeta de Credito Oro" TO PROD-NOMBRE.
           MOVE 1500.00 TO PROD-PRECIO.
           WRITE PROD-REG.
           
           CLOSE PRODUCTOS.
           STOP RUN.
```

---

## 4. Leer un Archivo Indexado (Modo Secuencial)

```cobol
           OPEN INPUT PRODUCTOS.
           
           PERFORM UNTIL PROD-EOF
               READ PRODUCTOS NEXT RECORD
                   AT END SET PROD-EOF TO TRUE
                   NOT AT END
                       DISPLAY PROD-ID " " PROD-NOMBRE
               END-READ
           END-PERFORM.
           
           CLOSE PRODUCTOS.
```

> 📝 `READ ... NEXT RECORD` es el modo secuencial dentro de un indexado.

---

## 5. Estructura Interna

Un archivo indexado se organiza como un **árbol B** (o variante):

```
          [Índice]
        /    |    \
    [100] [200] [300]
    /  \   /  \   /  \
  reg  reg reg reg reg reg
```

- El índice se construye automáticamente sobre RECORD KEY
- Las búsquedas por clave son O(log n)
- El acceso secuencial recorre según el orden del índice

---

## 6. Cuándo Usar Indexado

| Caso de uso | Recomendación |
|-------------|---------------|
| Catálogo de productos (consultas por ID) | ✅ Indexado |
| Archivo de transacciones (procesar todas en orden) | ✅ Secuencial |
| Maestro de clientes (consultas y actualizaciones) | ✅ Indexado |
| Log de eventos (solo escritura secuencial) | ✅ Secuencial |
| Búsqueda frecuente por clave | ✅ Indexado |
| Procesamiento batch masivo | ✅ Secuencial |

---

## ✅ Checklist

- [ ] Declarar archivo con ORGANIZATION IS INDEXED
- [ ] Definir RECORD KEY para la clave primaria
- [ ] Crear archivo indexado con OPEN OUTPUT
- [ ] Poblar registros con WRITE (verificando duplicados)
- [ ] Leer secuencialmente con READ NEXT
- [ ] Cerrar adecuadamente con CLOSE

## 📚 Recursos

- [GnuCOBOL Indexed Files](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Indexed-file-organization)
- [IBM COBOL Indexed File Organization](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-indexed-organization)
