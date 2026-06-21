# Dataset DISP — Ciclo de Vida

## 🎯 Objetivos

- Entender el ciclo de vida de un dataset en JCL
- Configurar DISP para diferentes escenarios
- Diferenciar datasets permanentes vs temporales

---

## 1. ¿Qué es DISP?

DISP (Disposition) controla el **estado** del dataset en tres momentos:

```
         Inicio del step   Fin normal    Fin con error
DISP=   (    NEW      ,    CATLG    ,    DELETE   )
```

---

## 2. Ciclo de Vida Típico

```
NEW → CATLG/DELETE
OLD → KEEP/DELETE
SHR → (sin cambio, solo lectura)
MOD → KEEP/DELETE
```

### Dataset nuevo que se guarda

```jcl
//SALIDA   DD   DSN=DATOS.REPORTE,DISP=(NEW,CATLG,DELETE)
```

- Se crea al inicio (NEW)
- Si termina bien: se cataloga (CATLG)
- Si termina mal: se elimina (DELETE)

### Dataset existente que se modifica

```jcl
//MAESTRO  DD   DSN=DATOS.MAESTRO,DISP=OLD
```

- Debe existir (OLD)
- Acceso exclusivo
- Al terminar: se conserva (KEEP por defecto)

---

## 3. Dataset Temporal (&&)

Los datasets temporales solo existen durante la ejecución del job:

```jcl
//STEP1    EXEC PGM=ORDENAR
//ENTRADA  DD   DSN=DATOS.ENTRADA,DISP=SHR
//TEMP     DD   DSN=&&ORDENADO,DISP=(NEW,PASS)
//*
//STEP2    EXEC PGM=REPORTE
//ENTRADA  DD   DSN=&&ORDENADO,DISP=(OLD,DELETE)
//SALIDA   DD   DSN=DATOS.REPORTE,DISP=(NEW,CATLG)
```

Flujo: STEP1 crea `&&ORDENADO` → STEP2 lo lee y lo elimina.

---

## 4. Combinaciones Comunes

| Escenario | DISP | Significado |
|-----------|------|-------------|
| Solo lectura | `DISP=SHR` | Compartido, sin cambios |
| Archivo nuevo | `DISP=(NEW,CATLG,DELETE)` | Crear, guardar OK, borrar error |
| Archivo nuevo temporal | `DISP=(NEW,PASS)` | Crear y pasar al siguiente step |
| Modificar existente | `DISP=OLD` o `DISP=MOD` | Acceso exclusivo o append |
| Reemplazar existente | `DISP=(NEW,CATLG,DELETE)` + mismo DSN | Sobrescribe (requiere DELETE previo) |

---

## 5. Catálogo del Sistema

Cuando usas `CATLG`, el dataset se registra en el catálogo del sistema. Luego puedes referenciarlo por nombre sin especificar ubicación física:

```jcl
      *> Primer uso: crear y catalogar
//CREAR    DD   DSN=DATOS.CLIENTES,DISP=(NEW,CATLG),
//             VOL=SER=USER01,UNIT=SYSDA
       
      *> Uso posterior: solo el DSN
//USAR     DD   DSN=DATOS.CLIENTES,DISP=SHR
```

---

## 6. Simulación Linux

En Linux, la simulación de DISP se hace con comandos del sistema:

```bash
# DISP=(NEW,CATLG) → crear archivo
> datos_salida.dat

# DISP=SHR → verificar que existe
if [ -f datos_entrada.dat ]; then
    echo "Dataset existe"
fi

# DISP=(NEW,PASS) → archivo temporal
temp_file=$(mktemp)
# ... usar temp_file ...

# DISP=(OLD,DELETE) → eliminar al terminar
rm -f "$temp_file"
```

---

## ✅ Checklist

- [ ] Configurar DISP=(NEW,CATLG,DELETE) para archivos de salida
- [ ] Usar DISP=SHR para archivos de solo lectura
- [ ] Usar && para datasets temporales entre steps
- [ ] Entender el ciclo NEW→PASS→OLD→DELETE

## 📚 Recursos

- [IBM JCL DISP Parameter](https://www.ibm.com/docs/en/zos/2.5?topic=dd-disp-parameter)
