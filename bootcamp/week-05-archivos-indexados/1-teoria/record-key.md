# RECORD KEY y ALTERNATE RECORD KEY

## 🎯 Objetivos

- Definir claves primarias (RECORD KEY)
- Agregar índices secundarios (ALTERNATE RECORD KEY)
- Permitir o prohibir duplicados (WITH DUPLICATES)

---

## 1. RECORD KEY — Clave Primaria

Es la clave principal de búsqueda. Debe ser **única** para cada registro.

```cobol
       SELECT CLIENTES
           ASSIGN TO "clientes.idx"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS CLI-ID
           FILE STATUS IS WS-FS-CLI.
```

### Características

- ✅ Debe estar dentro del registro FD (es un campo del layout)
- ✅ Valor **único** para cada registro
- ✅ Puede ser alfanumérico (X) o numérico (9)
- ✅ WRITE falla con FILE STATUS 22 si la clave ya existe
- ✅ Se usa para READ directo: `READ CLIENTES KEY IS CLI-ID`

---

## 2. ALTERNATE RECORD KEY — Claves Secundarias

Índices adicionales para búsqueda por otros campos:

```cobol
       SELECT EMPLEADOS
           ASSIGN TO "empleados.idx"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS EMP-ID
           ALTERNATE RECORD KEY IS EMP-RFC
               WITH DUPLICATES
           ALTERNATE RECORD KEY IS EMP-EMAIL
               WITH DUPLICATES
           FILE STATUS IS WS-FS-EMP.
```

### WITH DUPLICATES

Permite que la clave alterna tenga valores repetidos:

```cobol
      *> Varios empleados en el mismo departamento
       ALTERNATE RECORD KEY IS EMP-DEPTO WITH DUPLICATES.
       
      *> Varias cuentas del mismo cliente
       ALTERNATE RECORD KEY IS CTA-ID-CLIENTE WITH DUPLICATES.
```

Sin `WITH DUPLICATES`, un valor duplicado genera FILE STATUS 22.

---

## 3. Ejemplo Completo

```cobol
       FILE SECTION.
       FD  CUENTAS-FILE.
       01  CTA-REG.
           05 CTA-NUMERO       PIC 9(08).       *> Clave primaria
           05 CTA-ID-CLIENTE   PIC 9(05).       *> Clave alterna (puede repetirse)
           05 CTA-TIPO         PIC X(02).
           05 CTA-SALDO        PIC S9(09)V99.
           05 CTA-MONEDA       PIC X(03).
       
       FILE-CONTROL.
           SELECT CUENTAS
               ASSIGN TO "cuentas.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CTA-NUMERO
               ALTERNATE RECORD KEY IS CTA-ID-CLIENTE
                   WITH DUPLICATES
               ALTERNATE RECORD KEY IS CTA-TIPO
                   WITH DUPLICATES
               FILE STATUS IS WS-FS-CTA.
```

---

## 4. Búsqueda por Clave Alterna

```cobol
      *> Buscar todas las cuentas de un cliente
           MOVE 1042 TO CTA-ID-CLIENTE.
           READ CUENTAS KEY IS CTA-ID-CLIENTE
               INVALID KEY
                   DISPLAY "No hay cuentas del cliente"
               NOT INVALID KEY
                   PERFORM UNTIL EXIT
                       DISPLAY "Cuenta: " CTA-NUMERO
                           " Saldo: " CTA-SALDO
                       READ CUENTAS NEXT RECORD
                           AT END EXIT PERFORM
                       END-READ
                       IF CTA-ID-CLIENTE NOT = 1042
                           EXIT PERFORM
                       END-IF
                   END-PERFORM
           END-READ.
```

---

## 5. Cuándo Usar Claves Alternas

| Caso | Clave Primaria | Clave Alterna |
|------|---------------|---------------|
| Clientes | CLI-ID | CLI-RFC, CLI-EMAIL |
| Productos | PROD-ID | PROD-CODIGO-BARRAS |
| Empleados | EMP-LEGAJO | EMP-DNI, EMP-DEPTO |
| Cuentas bancarias | CTA-NUMERO | CTA-ID-CLIENTE |

---

## ✅ Checklist

- [ ] Declarar RECORD KEY sobre un campo único del registro
- [ ] Agregar ALTERNATE RECORD KEY para búsquedas secundarias
- [ ] Usar WITH DUPLICATES cuando la clave alterna puede repetirse
- [ ] Leer por clave alterna con READ KEY IS

## 📚 Recursos

- [IBM COBOL RECORD KEY Clause](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-record-key-clause)
- [IBM COBOL ALTERNATE RECORD KEY](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-alternate-record-key-clause)
