# LINKAGE SECTION — Paso de Parámetros

## 🎯 Objetivos

- Declarar parámetros en LINKAGE SECTION
- Hacer coincidir CALL USING con PROCEDURE DIVISION USING
- Pasar parámetros de distintos tipos
- Evitar errores comunes de desalineación

---

## 1. Estructura de LINKAGE SECTION

La LINKAGE SECTION está en DATA DIVISION y es exclusiva de subprogramas. Define los parámetros que recibe del programa llamador.

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULAR.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-TEMP        PIC 9(05).
       
       LINKAGE SECTION.
       01  LK-OPERANDO-1  PIC 9(05).
       01  LK-OPERANDO-2  PIC 9(05).
       01  LK-RESULTADO   PIC 9(10).
       
       PROCEDURE DIVISION USING LK-OPERANDO-1
                                LK-OPERANDO-2
                                LK-RESULTADO.
           COMPUTE LK-RESULTADO = LK-OPERANDO-1 + LK-OPERANDO-2.
           EXIT PROGRAM.
```

---

## 2. Correspondencia con CALL USING

### Llamador (principal)

```cobol
       WORKING-STORAGE SECTION.
       01  WS-OP1     PIC 9(05) VALUE 100.
       01  WS-OP2     PIC 9(05) VALUE 200.
       01  WS-RES     PIC 9(10) VALUE ZEROS.
       
           CALL "CALCULAR" USING WS-OP1 WS-OP2 WS-RES.
```

### Llamado (subprograma)

```cobol
       LINKAGE SECTION.
       01  LK-OP1     PIC 9(05).          *> Recibe WS-OP1
       01  LK-OP2     PIC 9(05).          *> Recibe WS-OP2
       01  LK-RES     PIC 9(10).          *> Recibe WS-RES (y puede modificarlo)
       
       PROCEDURE DIVISION USING LK-OP1 LK-OP2 LK-RES.
```

### Regla de oro

| Aspecto | Debe coincidir |
|---------|---------------|
| Cantidad | Mismo número de parámetros |
| Orden | Mismo orden posicional |
| Tamaño | Mismo PIC (o al menos mismo tamaño en bytes) |

---

## 3. LINKAGE con Niveles de Grupo

```cobol
       LINKAGE SECTION.
      *> Parámetro agrupado
       01  LK-CLIENTE.
           05 LK-CLI-ID       PIC 9(05).
           05 LK-CLI-NOMBRE   PIC X(30).
           05 LK-CLI-SALDO    PIC S9(07)V99.
       
      *> Parámetro simple
       01  LK-CODIGO-RETORNO  PIC X(02).
       
       PROCEDURE DIVISION USING LK-CLIENTE LK-CODIGO-RETORNO.
```

Llamada:

```cobol
           CALL "BUSCAR-CLIENTE" USING WS-CLIENTE WS-COD-RET.
```

---

## 4. Características de LINKAGE

- ❌ No puede tener VALUE (los valores vienen del llamador)
- ❌ No puede tener archivos (FD, SD)
- ✅ Puede tener tablas (OCCURS) si el tamaño es conocido
- ✅ Puede usar 88-level para condiciones
- ✅ Los cambios en LK-* afectan al llamador (BY REFERENCE, ver siguiente tema)

```cobol
       LINKAGE SECTION.
       01  LK-ESTADO      PIC X(01).
           88 LK-ACTIVO   VALUE "A".
           88 LK-INACTIVO VALUE "I".
```

---

## 5. Errores Comunes

### PIC no coincide

```cobol
      *> Llamador
       01  WS-MONTO    PIC 9(05)V99.       *> 7 bytes
      *> Subprograma
       01  LK-MONTO    PIC 9(07).           *> 7 bytes, PERO sin V
      *> ¡El punto decimal implícito queda en posición distinta!
```

**Solución**: Usar exactamente el mismo PIC en ambos lados. Mejor aún: usar COPYBOOK.

### Cantidad incorrecta

```cobol
           CALL "SUMA" USING A B R.        *> 3 parámetros
      *> Subprograma
       PROCEDURE DIVISION USING X Y.        *> 2 parámetros → ERROR
```

---

## 6. Múltiples Subprogramas

Un mismo programa principal puede llamar a varios subprogramas:

```cobol
           CALL "VALIDAR" USING WS-DATOS WS-ES-VALIDO.
           IF WS-ES-VALIDO
               CALL "CALCULAR" USING WS-DATOS WS-RESULTADO
               CALL "IMPRIMIR" USING WS-RESULTADO
           END-IF.
```

---

## ✅ Checklist

- [ ] Declarar LINKAGE SECTION en el subprograma
- [ ] Hacer coincidir CALL USING con PROCEDURE DIVISION USING
- [ ] Usar mismos PIC en llamador y llamado
- [ ] Prefijo `LK-` para parámetros
- [ ] Usar EXIT PROGRAM o GOBACK para retornar

## 📚 Recursos

- [GnuCOBOL LINKAGE SECTION](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#LINKAGE)
- [IBM COBOL LINKAGE Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=division-linkage-section)
