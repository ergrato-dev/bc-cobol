# Semana 04: Archivos Secuenciales

## 🎯 Objetivos

Al finalizar esta semana, el estudiante será capaz de:

- Configurar ENVIRONMENT DIVISION para archivos secuenciales
- Usar SELECT y ASSIGN para asociar archivos lógicos con físicos
- Implementar OPEN, READ, WRITE, CLOSE para archivos secuenciales
- Manejar FILE STATUS para control de errores
- Procesar archivos línea por línea con PERFORM UNTIL
- Implementar END-OF-FILE detection con AT END

## 📚 Contenido

### 1-teoria/

- **environment-division-archivos.md**: CONFIGURATION SECTION, INPUT-OUTPUT SECTION, FILE-CONTROL, SELECT/ASSIGN
- **organizacion-secuencial.md**: SEQUENTIAL, LINE SEQUENTIAL, RECORD SEQUENTIAL
- **verbos-archivo.md**: OPEN (INPUT/OUTPUT/EXTEND/I-O), READ, WRITE, CLOSE
- **file-status.md**: Códigos 00, 10, 35, y su manejo
- **procesamiento-secuencial.md**: Patrones: leer hasta EOF, procesar y escribir

### 2-practicas/

- **leer-archivo.cbl**: Leer archivo de texto y mostrar contenido
- **copiar-archivo.cbl**: Copiar archivo de entrada a archivo de salida
- **filtrar-datos.cbl**: Leer archivo CSV y filtrar registros

### 3-proyecto/

- **starter/reporte-cuentas.cbl**: Leer archivo de cuentas bancarias y generar reporte de saldos

## ⏱️ Distribución (10h)

- Teoría: 3h | Prácticas: 4h | Proyecto: 3h

## 📌 Entregables

- [ ] Programa que lee y muestra archivo
- [ ] Programa que copia archivos con FILE STATUS
- [ ] Proyecto de reporte de cuentas completado

## 🔗 Navegación

← [Semana 03](../week-03-procedure-division/README.md) | [Semana 05 →](../week-05-archivos-indexados/README.md)
