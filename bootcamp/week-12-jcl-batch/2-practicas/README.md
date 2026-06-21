# 2-practicas — Semana 12: JCL Fundamentos

Ejercicios de JCL simulado con scripts bash.

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `job-simple.jcl` | JOB + EXEC PGM, simulación de job simple |
| 2 | `job-multi-step.jcl` | Multi-step, COND, IF/THEN/ELSE |
| 3 | `job-procedimiento.jcl` | PROC con parámetros simbólicos |

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-12-jcl-batch/2-practicas

# Ejecutar job simple simulado
bash job-simple.jcl

# Ejecutar job multi-step
bash job-multi-step.jcl

# Ejecutar job con procedimiento
bash job-procedimiento.jcl
```

## 📝 Nota

Los archivos `.jcl` son scripts bash que **simulan** la sintaxis JCL en comentarios y ejecutan comandos reales. La sintaxis JCL real se muestra en los comentarios `# JCL:`.
