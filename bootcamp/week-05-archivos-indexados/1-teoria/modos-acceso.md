# Modos de Acceso: SEQUENTIAL, RANDOM, DYNAMIC

## 🎯 Objetivos

- Elegir ACCESS MODE según la necesidad
- Implementar acceso secuencial, aleatorio y dinámico
- Combinar modos de acceso con operaciones adecuadas

---

## 1. ACCESS MODE IS SEQUENTIAL

El modo por defecto. Los registros se leen en orden de RECORD KEY.

```cobol
       SELECT MAESTRO
           ASSIGN TO "maestro.idx"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS SEQUENTIAL
           RECORD KEY IS MAE-ID.
```

### Operaciones permitidas

- ✅ READ NEXT
- ❌ READ directo por clave
- ✅ WRITE (solo al crear/EXTEND)
- ❌ DELETE
- ❌ REWRITE

```cobol
           PERFORM UNTIL EOF
               READ MAESTRO NEXT RECORD
                   AT END SET EOF TO TRUE
                   NOT AT END DISPLAY MAE-REG
               END-READ
           END-PERFORM.
```

---

## 2. ACCESS MODE IS RANDOM

Acceso directo por clave. Cada READ requiere especificar la clave.

```cobol
       SELECT CATALOGO
           ASSIGN TO "catalogo.idx"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS RANDOM
           RECORD KEY IS CAT-ID.
```

### Operaciones permitidas

- ✅ READ con clave específica (obligatorio especificar KEY)
- ✅ WRITE (creación)
- ✅ DELETE
- ✅ REWRITE
- ❌ READ NEXT (no permitido en modo RANDOM)

```cobol
      *> Consulta directa
           MOVE 1042 TO CAT-ID.
           READ CATALOGO KEY IS CAT-ID
               INVALID KEY
                   DISPLAY "Producto no encontrado"
               NOT INVALID KEY
                   DISPLAY "Nombre: " CAT-NOMBRE
                   DISPLAY "Precio: " CAT-PRECIO
           END-READ.
       
      *> Actualizar precio
           COMPUTE CAT-PRECIO = CAT-PRECIO * 1.10.   *> +10%
           REWRITE CAT-REG.
```

---

## 3. ACCESS MODE IS DYNAMIC

El más flexible. Combina acceso secuencial y aleatorio en el mismo programa.

```cobol
       SELECT CLIENTES
           ASSIGN TO "clientes.idx"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS CLI-ID.
```

### Operaciones permitidas

- ✅ READ NEXT (secuencial)
- ✅ READ con clave específica
- ✅ START + READ NEXT (posicionarse y leer secuencial desde ahí)
- ✅ WRITE, DELETE, REWRITE

```cobol
      *> 1. Consulta directa (RANDOM)
           MOVE 1042 TO CLI-ID.
           READ CLIENTES KEY IS CLI-ID
               INVALID KEY DISPLAY "No encontrado"
               NOT INVALID KEY DISPLAY CLI-NOMBRE
           END-READ.
       
      *> 2. Recorrido secuencial desde ID 300
           MOVE 300 TO CLI-ID.
           START CLIENTES KEY IS GREATER THAN OR EQUAL TO CLI-ID
               INVALID KEY DISPLAY "No hay registros desde 300"
               NOT INVALID KEY
                   PERFORM UNTIL EOF
                       READ CLIENTES NEXT RECORD
                           AT END SET EOF TO TRUE
                           NOT AT END DISPLAY CLI-REG
                       END-READ
                   END-PERFORM
           END-START.
```

---

## 4. Tabla Comparativa

| Característica | SEQUENTIAL | RANDOM | DYNAMIC |
|---------------|-----------|--------|---------|
| READ NEXT | ✅ | ❌ | ✅ |
| READ por clave | ❌ | ✅ | ✅ |
| START | ❌ | ❌ | ✅ |
| DELETE | ❌ | ✅ | ✅ |
| REWRITE | ❌ | ✅ | ✅ |
| Uso típico | Reportes, batch | Consultas puntuales | CRUD, mantenimiento |

> 🎯 **Recomendación**: Usa ACCESS MODE IS DYNAMIC para la mayoría de los casos. Te da máxima flexibilidad.

---

## 5. Combinar Patrones de Acceso

```cobol
      *> DYNAMIC permite alternar entre modos
           OPEN I-O CATALOGO.
           
      *> Actualizar un producto específico
           MOVE WS-ID-BUSCAR TO CAT-ID.
           READ CATALOGO KEY IS CAT-ID
               INVALID KEY
                   DISPLAY "ID no encontrado"
               NOT INVALID KEY
                   MOVE WS-NUEVO-PRECIO TO CAT-PRECIO
                   REWRITE CAT-REG
                   DISPLAY "Actualizado: " CAT-ID
           END-READ.
           
      *> Luego recorrer todos secuencialmente
           MOVE ZEROS TO CAT-ID.
           START CATALOGO KEY IS GREATER THAN CAT-ID
               INVALID KEY CONTINUE
               NOT INVALID KEY
                   PERFORM UNTIL EOF
                       READ CATALOGO NEXT RECORD
                           AT END SET EOF TO TRUE
                           NOT AT END DISPLAY CAT-REG
                       END-READ
                   END-PERFORM
           END-START.
           
           CLOSE CATALOGO.
```

---

## ✅ Checklist

- [ ] Usar ACCESS MODE IS SEQUENTIAL para lectura secuencial
- [ ] Usar ACCESS MODE IS RANDOM para consultas por clave
- [ ] Usar ACCESS MODE IS DYNAMIC para CRUD completo
- [ ] Combinar START + READ NEXT para rangos
- [ ] Elegir el modo correcto según operaciones necesarias

## 📚 Recursos

- [GnuCOBOL ACCESS MODE](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#ACCESS-MODE)
- [IBM COBOL ACCESS MODE](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-access-mode-clause)
