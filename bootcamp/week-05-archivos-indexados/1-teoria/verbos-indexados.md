# Verbos Indexados: START, DELETE, REWRITE

## 🎯 Objetivos

- Posicionar el cursor con START antes de lectura secuencial
- Eliminar registros con DELETE
- Actualizar registros con REWRITE
- Manejar INVALID KEY en todas las operaciones

---

## 1. START — Posicionar el Cursor

START posiciona el archivo en un registro específico para luego leer secuencialmente con READ NEXT.

```cobol
       START nombre-archivo
           KEY IS [EQUAL TO | GREATER THAN | NOT LESS THAN] clave
           INVALID KEY sentencias...
           NOT INVALID KEY sentencias...
       END-START.
```

### Operadores de START

| Operador | Significado | Ejemplo |
|----------|-------------|---------|
| `KEY IS EQUAL TO` | Posiciona exactamente en la clave | `START ... KEY IS EQUAL TO WS-ID` |
| `KEY IS GREATER THAN` | Mayor estricto que la clave | `START ... KEY > WS-ID` |
| `KEY IS NOT LESS THAN` | Mayor o igual a la clave | `START ... KEY >= WS-ID` |
| `KEY IS GREATER THAN OR EQUAL TO` | Mayor o igual (sinónimo de NOT LESS THAN) | `START ... KEY >= WS-ID` |

### Ejemplos

```cobol
      *> Leer desde el ID 500 en adelante
           MOVE 500 TO PROD-ID.
           START PRODUCTOS KEY IS GREATER THAN OR EQUAL TO PROD-ID
               INVALID KEY
                   DISPLAY "No hay productos desde ID 500"
               NOT INVALID KEY
                   PERFORM UNTIL EOF
                       READ PRODUCTOS NEXT RECORD ...
                   END-PERFORM
           END-START.
       
      *> Posicionarse en la primera clave (inicio del archivo)
           MOVE ZEROS TO PROD-ID.
           START PRODUCTOS KEY IS GREATER THAN PROD-ID
               INVALID KEY
                   DISPLAY "Archivo vacio"
               NOT INVALID KEY
                   DISPLAY "Inicio del archivo"
           END-START.
```

---

## 2. DELETE — Eliminar Registro

Elimina el registro actual (el último leído con READ).

```cobol
       DELETE nombre-archivo RECORD
           INVALID KEY sentencias...
       END-DELETE.
```

> ⚠️ DELETE requiere ACCESS MODE RANDOM o DYNAMIC, y OPEN I-O.

```cobol
      *> Eliminar un producto por ID
           MOVE WS-ID-ELIMINAR TO PROD-ID.
           READ PRODUCTOS KEY IS PROD-ID
               INVALID KEY
                   DISPLAY "Producto no encontrado"
               NOT INVALID KEY
                   DISPLAY "Eliminando: " PROD-NOMBRE
                   DELETE PRODUCTOS RECORD
                       INVALID KEY
                           DISPLAY "Error al eliminar"
                   END-DELETE
           END-READ.
```

---

## 3. REWRITE — Actualizar Registro

Reemplaza el registro actual (previamente leído con READ) con los nuevos valores.

```cobol
       REWRITE nombre-registro
           INVALID KEY sentencias...
       END-REWRITE.
```

> ⚠️ REWRITE usa el **nombre del registro** (01 del FD), no el nombre del archivo. Requiere ACCESS MODE RANDOM o DYNAMIC, y OPEN I-O.

```cobol
      *> Actualizar precio de un producto
           MOVE WS-ID-ACTUALIZAR TO PROD-ID.
           READ PRODUCTOS KEY IS PROD-ID
               INVALID KEY
                   DISPLAY "Producto no encontrado"
               NOT INVALID KEY
                   DISPLAY "Precio actual: " PROD-PRECIO
                   COMPUTE PROD-PRECIO = PROD-PRECIO * 1.10
                   DISPLAY "Nuevo precio: " PROD-PRECIO
                   REWRITE PROD-REG
                       INVALID KEY
                           DISPLAY "Error al actualizar"
                   END-REWRITE
           END-READ.
```

> ⚠️ **Importante**: No puedes cambiar el valor de RECORD KEY en un REWRITE. Si lo haces, obtienes INVALID KEY.

---

## 4. OPEN I-O — Modo Lectura/Escritura

Para usar DELETE y REWRITE, el archivo debe abrirse con `OPEN I-O`:

```cobol
           OPEN I-O PRODUCTOS.       *> Lectura y escritura
           OPEN INPUT CLIENTES.      *> Solo lectura
           OPEN OUTPUT REPORTE.      *> Solo escritura (crea/sobrescribe)
```

| Modo OPEN | READ | WRITE | REWRITE | DELETE | START |
|-----------|------|-------|---------|--------|-------|
| INPUT | ✅ | ❌ | ❌ | ❌ | ✅ |
| OUTPUT | ❌ | ✅ | ❌ | ❌ | ❌ |
| I-O | ✅ | ❌ | ✅ | ✅ | ✅ |
| EXTEND | ❌ | ✅ | ❌ | ❌ | ❌ |

---

## 5. CRUD Completo con Archivo Indexado

```cobol
       PROCEDURE DIVISION.
       MAIN.
           OPEN I-O CATALOGO.
           IF NOT CAT-OK
               DISPLAY "Error abriendo catalogo"
               STOP RUN
           END-IF.
           
           DISPLAY "1=Consultar 2=Agregar 3=Modificar 4=Eliminar 9=Salir".
           ACCEPT WS-OPCION.
           EVALUATE WS-OPCION
               WHEN 1 PERFORM 2000-CONSULTAR
               WHEN 2 PERFORM 3000-AGREGAR
               WHEN 3 PERFORM 4000-MODIFICAR
               WHEN 4 PERFORM 5000-ELIMINAR
           END-EVALUATE.
           
           CLOSE CATALOGO.
           STOP RUN.
       
       2000-CONSULTAR.
           DISPLAY "ID a consultar: " WITH NO ADVANCING.
           ACCEPT CAT-ID.
           READ CATALOGO KEY IS CAT-ID
               INVALID KEY
                   DISPLAY "No encontrado"
               NOT INVALID KEY
                   DISPLAY CAT-NOMBRE " $" CAT-PRECIO
           END-READ.
       
       3000-AGREGAR.
           DISPLAY "ID nuevo: " WITH NO ADVANCING.
           ACCEPT CAT-ID.
           DISPLAY "Nombre: " WITH NO ADVANCING.
           ACCEPT CAT-NOMBRE.
           DISPLAY "Precio: " WITH NO ADVANCING.
           ACCEPT CAT-PRECIO.
           WRITE CAT-REG
               INVALID KEY
                   DISPLAY "ERROR: ID ya existe"
               NOT INVALID KEY
                   DISPLAY "Agregado correctamente"
           END-WRITE.
       
       4000-MODIFICAR.
           DISPLAY "ID a modificar: " WITH NO ADVANCING.
           ACCEPT CAT-ID.
           READ CATALOGO KEY IS CAT-ID
               INVALID KEY DISPLAY "No encontrado"
               NOT INVALID KEY
                   DISPLAY "Precio actual: " CAT-PRECIO
                   DISPLAY "Nuevo precio: " WITH NO ADVANCING
                   ACCEPT WS-NUEVO-PRECIO
                   MOVE WS-NUEVO-PRECIO TO CAT-PRECIO
                   REWRITE CAT-REG
                   DISPLAY "Modificado"
           END-READ.
       
       5000-ELIMINAR.
           DISPLAY "ID a eliminar: " WITH NO ADVANCING.
           ACCEPT CAT-ID.
           READ CATALOGO KEY IS CAT-ID
               INVALID KEY DISPLAY "No encontrado"
               NOT INVALID KEY
                   DELETE CATALOGO RECORD
                   DISPLAY "Eliminado"
           END-READ.
```

---

## ✅ Checklist

- [ ] Usar START para posicionar antes de READ NEXT
- [ ] Usar KEY IS GREATER THAN OR EQUAL TO para rangos
- [ ] Eliminar con DELETE después de READ exitoso
- [ ] Actualizar con REWRITE después de READ exitoso
- [ ] Manejar INVALID KEY en START, DELETE y REWRITE
- [ ] Abrir con OPEN I-O para DELETE y REWRITE

## 📚 Recursos

- [IBM COBOL START Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-start-statement)
- [IBM COBOL DELETE Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-delete-statement)
- [IBM COBOL REWRITE Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-rewrite-statement)
