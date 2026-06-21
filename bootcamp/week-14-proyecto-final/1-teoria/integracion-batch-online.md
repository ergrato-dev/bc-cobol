# Integración Batch + Online + SQL

## 🎯 Objetivos

- Integrar módulos batch y online en un sistema cohesivo
- Compartir COPYBOOKS entre todos los módulos
- Conectar COBOL batch con PostgreSQL
- Generar reportes que combinen datos de archivos y BD

---

## 1. Flujo Completo del Sistema

```
                    ┌──────────────────┐
                    │   PostgreSQL     │
                    │   CLIENTES       │
                    │   CUENTAS        │
                    └───┬──────────┬───┘
                        │          │
              ┌─────────┘          └─────────┐
              ▼                              ▼
    ┌──────────────────┐           ┌──────────────────┐
    │  MÓDULO BATCH    │           │  MÓDULO ONLINE   │
    │  (nocturno)      │           │  (diurno)        │
    └──────────────────┘           └──────────────────┘
              │                              │
              ▼                              ▼
    ┌──────────────────┐           ┌──────────────────┐
    │  Archivos        │           │  Terminal        │
    │  cuentas.idx     │           │  (CICS simulado) │
    │  cierre_diario   │           │  ACCEPT/DISPLAY  │
    └──────────────────┘           └──────────────────┘
```

---

## 2. Compartición de COPYBOOKS

Todos los módulos usan los mismos COPYBOOKS:

```cobol
      *> En batch/validar.cbl
       COPY "copybooks/transacc.cpy".
       COPY "copybooks/errores.cpy".
       
      *> En online/consulta-online.cbl
       COPY "copybooks/cuentas.cpy".
       COPY "copybooks/errores.cpy".
       
      *> En sql/consulta-sql.cbl
       COPY "copybooks/errores.cpy".
```

Compilar con ruta a copybooks:

```bash
cobc -x -free -I copybooks programa.cbl
```

---

## 3. Integración con PostgreSQL

### Conexión desde batch

```cobol
      *> Al inicio del batch, sincronizar saldos con PostgreSQL
           EXEC SQL
               SELECT SALDO INTO :WS-SALDO-DB
               FROM CUENTAS
               WHERE ID_CUENTA = :WS-ID-CUENTA
           END-EXEC.
```

### Conexión desde online

```cobol
      *> Consulta de cliente desde pantalla CICS simulada
           EXEC SQL
               SELECT NOMBRE, APELLIDO
               INTO :WS-NOMBRE, :WS-APELLIDO
               FROM CLIENTES
               WHERE ID_CLIENTE = :WS-ID-CLIENTE
           END-EXEC.
           
           IF SQL-OK
               DISPLAY "Cliente: " WS-NOMBRE " " WS-APELLIDO
           END-IF.
```

---

## 4. Ciclo de Vida Diario

```
06:00 - Inicio del día
  │
  ▼
08:00 - MÓDULO ONLINE activo
  │     Clientes consultan saldos, hacen transacciones
  │     Las transacciones se acumulan en transacciones.dat
  │
  ▼
18:00 - Cierre del día (ya no se aceptan transacciones)
  │
  ▼
22:00 - MÓDULO BATCH se ejecuta (batch.sh)
  │     STEP1: Validar transacciones
  │     STEP2: Ordenar por cuenta
  │     STEP3: Actualizar maestro (cuentas.idx)
  │     STEP4: Generar reporte cierre
  │
  ▼
23:00 - Reporte listo para revisión
  │     cierre_diario.txt + trans_rechazadas.dat
  │
  ▼
06:00 - Nuevo día, el ciclo se repite
```

---

## 5. Control de Errores Global

### COPYBOOK de errores compartido

```cobol
       01  WS-FS             PIC X(02).
           88 FS-OK          VALUE "00".
           88 FS-EOF         VALUE "10".
           88 FS-NO-FILE     VALUE "35".
       
       01  WS-COD-ERROR      PIC X(02).
           88 COD-OK         VALUE "00".
           88 COD-NO-DATA    VALUE "01".
           88 COD-TIPO-INVAL VALUE "02".
           88 COD-MONTO-NEG  VALUE "03".
           88 COD-CUENTA-NF  VALUE "04".
```

Todos los módulos usan estos códigos para comunicar errores de forma consistente.

---

## 6. Testing Integrado

```bash
#!/bin/bash
# test.sh - Pruebas de integración del sistema bancario
set -e

echo "=== PREPARANDO DATOS ==="
cp data/transacciones_prueba.dat transacciones.dat

echo "=== STEP 1: VALIDAR ==="
cobc -x -free -I copybooks batch/validar.cbl -o validar
./validar
diff trans_validas.dat expected/trans_validas_expected.dat

echo "=== STEP 2: ORDENAR ==="
sort -t'|' -k2,2 trans_validas.dat > trans_ordenadas.dat

echo "=== STEP 3: ACTUALIZAR MAESTRO ==="
cp data/cuentas_inicial.idx cuentas.idx
cobc -x -free -I copybooks batch/actualizar.cbl -o actualizar
./actualizar

echo "=== STEP 4: VERIFICAR SALDOS ==="
cobc -x -free -I copybooks online/consulta-online.cbl -o consulta
echo "00101" | ./consulta | grep "15000.50"

echo "✅ Todos los tests pasaron"
```

---

## ✅ Checklist

- [ ] COPYBOOKS compartidos entre batch y online
- [ ] Conexión a PostgreSQL desde ambos módulos
- [ ] Control de errores unificado (COPYBOOK errores.cpy)
- [ ] Script batch.sh con control de RC entre steps
- [ ] Script test.sh con casos de prueba y verificación diff

## 📚 Recursos

- [GnuCOBOL Subprogram Guide](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#CALL)
- [PostgreSQL Embedded SQL](https://www.postgresql.org/docs/16/ecpg.html)
