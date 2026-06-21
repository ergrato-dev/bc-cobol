# Semana 12: JCL Fundamentos

## 🎯 Objetivos

Al finalizar esta semana, el estudiante será capaz de:

- Comprender la estructura de un job JCL (JOB, EXEC, DD)
- Escribir JCL para ejecutar programas COBOL en batch
- Configurar DD statements para archivos de entrada/salida
- Manejar disposición de datasets (DISP)
- Simular JCL en Linux con scripts bash
- Implementar procedimientos catalogados simples

## 📚 Contenido

### 1-teoria/

- **estructura-jcl.md**: JOB statement, accounting, parámetros
- **exec-statement.md**: PGM, PARM, COND, REGION
- **dd-statement.md**: DD, DSNAME, DISP, SPACE, DCB
- **disp-datasets.md**: NEW, OLD, SHR, MOD, CATLG, DELETE, KEEP
- **procedimientos.md**: PROC, PEND, parámetros simbólicos

### 2-practicas/

- **job-simple.jcl**: Job que ejecuta un programa COBOL simple
- **job-multi-step.jcl**: Job con múltiples EXEC steps encadenados
- **job-procedimiento.jcl**: Uso de PROC para reutilizar steps

### 3-proyecto/

- **starter/procesamiento-batch-completo.cbl**: Job batch que ejecuta 3 programas COBOL en secuencia: validar datos → ordenar → generar reporte

## ⏱️ Distribución (10h)

- Teoría: 3h | Prácticas: 4h | Proyecto: 3h

## 📌 Entregables

- [ ] Job simple que ejecuta un programa COBOL
- [ ] Job multi-step con dependencias
- [ ] Proyecto de procesamiento batch completado

## 🔗 Navegación

← [Semana 11](../week-11-sql-embebido/README.md) | [Semana 13 →](../week-13-cics-online/README.md)
