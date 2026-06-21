# Arquitectura del Sistema Bancario

## 🎯 Objetivos

- Diseñar un sistema bancario completo con módulos batch y online
- Integrar todas las tecnologías aprendidas en el bootcamp
- Aplicar arquitectura modular con COPYBOOKS y subprogramas

---

## 1. Visión General

```
┌─────────────────────────────────────────────────────┐
│              SISTEMA BANCARIO                       │
├─────────────────────┬───────────────────────────────┤
│   MÓDULO BATCH      │      MÓDULO ONLINE            │
│   (Procesos diarios)│      (Consulta clientes)      │
├─────────────────────┼───────────────────────────────┤
│ • Validar transacc. │ • Pantalla de menú            │
│ • Ordenar (SORT)    │ • Consulta de saldo           │
│ • Actualizar maestro│ • Consulta SQL (PostgreSQL)   │
│ • Reporte cierre    │ • Pseudo-conversación         │
├─────────────────────┴───────────────────────────────┤
│              CAPA DE DATOS                          │
│  • Archivo maestro (indexado)                       │
│  • Archivo transacciones (secuencial)               │
│  • PostgreSQL (clientes)                            │
├─────────────────────────────────────────────────────┤
│              COPYBOOKS COMPARTIDOS                  │
│  cuentas.cpy · transacc.cpy · errores.cpy · fechas.cpy │
└─────────────────────────────────────────────────────┘
```

---

## 2. Módulo Batch — Flujo

```
transacciones.dat ──→ VALIDAR ──→ trans_validas.dat
                                    trans_rechazadas.dat
                                            │
trans_validas.dat ──→  SORT   ──→ trans_ordenadas.dat
                                            │
cuentas.idx ─────────→ ACTUALIZAR ←────────┘
                      MAESTRO
                          │
                          ↓
                   REPORTE CIERRE
                   cierre_diario.txt
```

### Programas

| Step | Programa | Entrada | Salida |
|------|----------|---------|--------|
| 1 | `validar` | `transacciones.dat` | `trans_validas.dat`, `trans_rechazadas.dat` |
| 2 | `ordenar` | `trans_validas.dat` | `trans_ordenadas.dat` (SORT interno) |
| 3 | `actualizar` | `cuentas.idx` + `trans_ordenadas.dat` | `cuentas.idx` (in-place) |
| 4 | `reporte` | `cuentas.idx` + `trans_ordenadas.dat` | `cierre_diario.txt` |

---

## 3. Módulo Online — Flujo

```
        MENÚ PRINCIPAL
        ┌────────────┐
        │ 1. Consulta │──→ Pantalla ingreso cuenta
        │ 2. SQL      │──→ Pantalla búsqueda cliente
        │ 9. Salir    │
        └────────────┘
               ↑
               │ (COMMAREA simulada: retorno al menú)
               │
        ┌──────┴──────────┐
        │ RESULTADO        │
        │ Cuenta: 00101    │
        │ Nombre: Juan P.  │
        │ Saldo: $15,000.50│
        └─────────────────┘
```

### Programas

| Programa | Función | Datos |
|----------|---------|-------|
| `consulta-online` | Simula pantalla CICS, menú, consulta, resultado | `cuentas.idx` (archivo indexado) |
| `consulta-sql` | Consulta de clientes vía PostgreSQL | Tabla `CLIENTES` (SQL embebido) |

---

## 4. Capa de Datos

### Archivos

| Archivo | Organización | Contenido |
|---------|-------------|-----------|
| `cuentas.idx` | INDEXED | Maestro de cuentas (ID, nombre, tipo, saldo) |
| `transacciones.dat` | LINE SEQUENTIAL | Transacciones del día (tipo|cuenta|monto|desc) |
| `trans_validas.dat` | LINE SEQUENTIAL | Transacciones que pasaron validación |
| `trans_rechazadas.dat` | LINE SEQUENTIAL | Transacciones con errores |
| `trans_ordenadas.dat` | LINE SEQUENTIAL | Transacciones válidas ordenadas por cuenta |
| `cierre_diario.txt` | LINE SEQUENTIAL | Reporte final del día |

### Base de Datos

| Tabla | Motor | Uso |
|-------|-------|-----|
| `CLIENTES` | PostgreSQL | Datos maestros de clientes |
| `CUENTAS` | PostgreSQL | Cuentas con saldo |
| `TRANSACCIONES` | PostgreSQL | Histórico de movimientos |

---

## 5. COPYBOOKS Compartidos

```
copybooks/
├── cuentas.cpy      # Layout de cuenta (batch + online)
├── transacc.cpy     # Layout de transacción
├── errores.cpy      # Códigos de error y FILE STATUS
└── fechas.cpy       # Validación y formateo de fechas
```

---

## 6. Orquestación (batch.sh)

El script `batch.sh` simula JCL y ejecuta los steps en secuencia:

```bash
#!/bin/bash
echo "JOB: BATCHDIA - Procesamiento Diario"
./validar              # Step 1
if [ $? -eq 0 ]; then
    sort trans_validas.dat > trans_ordenadas.dat  # Step 2
    ./actualizar        # Step 3
    ./reporte           # Step 4
fi
```

---

## ✅ Checklist de Arquitectura

- [ ] Módulo batch con 4 steps encadenados
- [ ] Módulo online con pseudo-conversación
- [ ] COPYBOOKS compartidos entre batch y online
- [ ] Archivo maestro indexado + archivo transacciones secuencial
- [ ] PostgreSQL para datos de clientes
- [ ] Script `batch.sh` orquestador
- [ ] Script `test.sh` con pruebas de integración

## 📚 Recursos

- [GnuCOBOL Modular Programming](https://gnucobol.sourceforge.io/HTML/gnucobpg.html)
