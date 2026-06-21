# Comparativa de Archivos: Secuencial vs Indexado vs Relativo

## 🎯 Objetivos

- Comparar los tres tipos de organización
- Elegir la organización correcta para cada caso de uso
- Comprender fortalezas y limitaciones de cada tipo

---

## 1. Tabla Comparativa

| Característica | SEQUENTIAL | INDEXED | RELATIVE |
|---------------|-----------|---------|----------|
| Acceso por posición | ❌ | ❌ | ✅ (por número de registro) |
| Acceso por clave | ❌ | ✅ | ❌ |
| Acceso secuencial | ✅ | ✅ | ✅ |
| Búsqueda eficiente | ❌ O(n) | ✅ O(log n) | ✅ O(1) directo |
| Tamaño del archivo | Mínimo | Mayor (+índices) | Medio |
| Complejidad | Baja | Media | Baja-Media |
| Clave duplicada | N/A (no hay clave) | ❌ (salvo ALTERNATE) | N/A |
| Flexibilidad | Baja | Alta | Media |
| OPEN I-O (modificar) | ❌ | ✅ | ✅ |

---

## 2. Secuencial (SEQUENTIAL / LINE SEQUENTIAL)

### A favor
- Simplicidad máxima
- Menor tamaño de archivo
- Ideal para procesamiento batch y reportes
- Archivos de texto legibles (LINE SEQUENTIAL)

### En contra
- No hay acceso directo
- Búsqueda requiere leer todo el archivo
- No permite DELETE ni REWRITE
- Modificar un registro requiere reescribir todo el archivo

### Casos de uso
- ✅ Archivos de transacciones del día
- ✅ Logs y bitácoras
- ✅ Reportes generados
- ✅ Archivos de importación/exportación
- ❌ Catálogo de clientes (mejor indexado)

---

## 3. Indexado (INDEXED)

### A favor
- Búsqueda rápida por clave primaria (O(log n))
- Múltiples índices (ALTERNATE RECORD KEY)
- Permite DELETE y REWRITE
- START para lectura por rangos
- DYNAMIC combina acceso secuencial y aleatorio

### En contra
- Mayor tamaño de archivo (índices)
- Más complejo de administrar
- Índices pueden corromperse
- Performance de escritura menor (mantener índices)

### Casos de uso
- ✅ Maestro de clientes
- ✅ Catálogo de productos
- ✅ Maestro de cuentas bancarias
- ✅ Cualquier entidad consultada por ID
- ❌ Archivos de logs (desperdicio de índices)

---

## 4. Relativo (RELATIVE)

Accede por **número de registro** (como un array en disco).

```cobol
       SELECT EMPLEADOS
           ASSIGN TO "empleados.rel"
           ORGANIZATION IS RELATIVE
           ACCESS MODE IS DYNAMIC
           RELATIVE KEY IS WS-REG-NUM.
```

### A favor
- Acceso directo O(1) por número de registro
- Simple de entender (como un array)
- Útil cuando el número de registro tiene significado

### En contra
- No tiene clave de negocio (solo número)
- Los registros eliminados dejan "huecos"
- Menos usado en la práctica moderna

### Casos de uso
- ✅ Archivos con numeración natural (legajos, folios)
- ✅ Tablas hash simples
- ❌ La mayoría de casos usa mejor INDEXED

---

## 5. Guía de Decisión Rápida

```
¿Necesitas consultar por un campo específico (ID, código)?
├── SÍ → INDEXED (RECORD KEY = ese campo)
└── NO  → ¿Procesas todos los registros en orden?
          ├── SÍ → SEQUENTIAL
          └── NO  → ¿Accedes por número de registro (fila 1, fila 2)?
                    ├── SÍ → RELATIVE
                    └── NO  → Repensar el diseño
```

---

## 6. Ejemplo: Mismo Problema, Distinta Organización

**Problema**: Almacenar 100,000 clientes y permitir consulta por ID, actualización de saldo y reporte mensual.

### Solución Secuencial (mala)
- ❌ Consulta por ID: leer hasta encontrar (~50K lecturas en promedio)
- ❌ Actualizar: leer todo, modificar en memoria, reescribir todo
- ✅ Reporte: leer secuencialmente (único punto bueno)

### Solución Indexada (correcta)
- ✅ Consulta por ID: READ KEY IS CLI-ID (~4 lecturas B-tree)
- ✅ Actualizar: READ → REWRITE in-place
- ✅ Reporte: START → READ NEXT secuencial

---

## ✅ Checklist

- [ ] Diferenciar SEQUENTIAL, INDEXED y RELATIVE
- [ ] Elegir INDEXED para catálogos y maestros consultables
- [ ] Elegir SEQUENTIAL para procesamiento batch
- [ ] Conocer que RELATIVE existe pero es menos usado
- [ ] Justificar la elección de organización para un caso dado

## 📚 Recursos

- [IBM COBOL File Organization Comparison](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-file-organization)
- [GnuCOBOL File Organization](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#File-organization)
