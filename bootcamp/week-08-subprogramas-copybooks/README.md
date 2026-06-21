# Semana 08: Subprogramas y COPYBOOKS

## 🎯 Objetivos

Al finalizar esta semana, el estudiante será capaz de:

- Crear subprogramas COBOL con PROGRAM-ID
- Llamar subprogramas con CALL y USING
- Pasar parámetros BY REFERENCE y BY CONTENT
- Diseñar LINKAGE SECTION correctamente
- Usar COPY para incluir COPYBOOKS
- Diferenciar programas anidados (CONTAINS) de subprogramas externos
- Implementar CANCEL para liberar subprogramas de memoria

## 📚 Contenido

### 1-teoria/

- **call-statement.md**: CALL literal, CALL variable, USING, returning
- **linkage-section.md**: Definición de parámetros, correspondencia CALL/USING
- **by-reference-by-content.md**: Paso por referencia vs valor
- **copybooks.md**: COPY, REPLACE, estructura de COPYBOOKS
- **programas-anidados.md**: CONTAINS, scope de variables, COMMON PROGRAM

### 2-practicas/

- **calculadora-modular.cbl**: Programa principal + subprogramas (sumar, restar)
- **validaciones.cpy**: COPYBOOK de validaciones reutilizables
- **fecha-util.cbl**: Subprograma de utilidades de fecha

### 3-proyecto/

- **starter/sistema-bancario-modular.cbl**: Sistema con programa principal y subprogramas (consultar, depositar, retirar) usando COPYBOOKS compartidos

## ⏱️ Distribución (10h)

- Teoría: 3h | Prácticas: 4h | Proyecto: 3h

## 📌 Entregables

- [ ] Calculadora modular con CALL
- [ ] COPYBOOK de validaciones reutilizado
- [ ] Proyecto de sistema bancario modular completado

## 🔗 Navegación

← [Semana 07](../week-07-string-manipulacion/README.md) | [Semana 09 →](../week-09-reportes-batch/README.md)
