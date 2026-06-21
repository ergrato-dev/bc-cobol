# Historia de COBOL

## 🎯 Objetivos

- Comprender el origen y propósito de COBOL como lenguaje de negocios
- Identificar los hitos clave en la evolución de los estándares
- Valorar la relevancia actual de COBOL en la industria financiera

---

## 1. Origen: 1959

COBOL (**CO**mmon **B**usiness **O**riented **L**anguage) nació en 1959 de un esfuerzo del Departamento de Defensa de EE.UU. El objetivo era crear un lenguaje de programación portable para aplicaciones de negocio.

### El comité CODASYL

- **CODASYL** (Conference on Data Systems Languages) — comité formado por fabricantes de computadoras y el gobierno
- **Grace Hopper** — almirante y pionera de la computación, impulsora del concepto de lenguajes de alto nivel cercanos al inglés
- Primera especificación: **diciembre 1959**
- Primer compilador: **1960** (RCA y Remington-Rand Univac)

### Filosofía de diseño

> "Que el código sea legible para gerentes de banco, no solo para programadores"

- Sintaxis basada en **inglés natural** (MOVE, ADD, DISPLAY)
- Separación estricta entre **datos** y **procedimientos**
- Orientado a **archivos** y **reportes** (no a cálculos científicos)
- Portabilidad entre fabricantes de hardware

---

## 2. Evolución de Estándares

| Estándar | Año | Principales Adiciones |
|----------|-----|----------------------|
| **COBOL-68** | 1968 | Primer estándar ANSI. Tablas (OCCURS), archivos indexados |
| **COBOL-74** | 1974 | Módulos (CALL), STRING/UNSTRING, comunicación entre programas |
| **COBOL-85** | 1985 | Programación estructurada (END-IF, EVALUATE, PERFORM anidado), INSPECT, CONTINUE |
| **COBOL 2002** | 2002 | Orientación a objetos, FREE FORMAT, funciones intrínsecas, validación |
| **COBOL 2014** | 2014 | Dynamic tables, JSON parsing, funciones matemáticas ampliadas |
| **COBOL 2023** | 2023 | Async processing, UTF-8 nativo, mejoras de seguridad |

> 📝 Este bootcamp usa **GnuCOBOL 3.2+** que implementa COBOL 85 con extensiones de COBOL 2002 y 2014.

---

## 3. COBOL en la Actualidad

### Estadísticas impactantes

- **~220 mil millones** de líneas de código COBOL activas en producción
- **95%** de transacciones ATM pasan por COBOL
- **80%** de transacciones financieras globales involucran COBOL
- **43%** de sistemas bancarios en EE.UU. corren COBOL
- **70%** de datos de negocio críticos se procesan en COBOL

### ¿Dónde se usa?

- 🏦 **Banca**: procesamiento de transacciones, cuentas, préstamos
- 🏛️ **Gobierno**: seguridad social, impuestos, registros civiles
- 🏥 **Salud**: sistemas de pacientes, facturación médica
- ✈️ **Aerolíneas**: sistemas de reservas (Sabre originalmente COBOL)
- 📦 **Logística**: inventarios, cadena de suministro
- 🛡️ **Seguros**: pólizas, reclamos, primas

### ¿Por qué sigue vivo?

1. **Costo de migración**: reemplazar 220B líneas es inviable económicamente
2. **Confiabilidad**: décadas de funcionamiento sin errores críticos
3. **Rendimiento**: procesamiento batch masivo optimizado
4. **Precisión decimal**: aritmética de punto fijo exacta (no floats)
5. **Modernización**: integración con Java, C, servicios web, APIs REST

---

## 4. COBOL vs Lenguajes Modernos

| Característica | COBOL | Python | Java |
|---------------|-------|--------|------|
| Propósito | Negocios | General | General |
| Legibilidad | Inglés natural | Cercano a pseudo-código | Verbo-Objeto |
| Aritmética | Punto fijo nativo | IEEE 754 float | IEEE 754 float |
| Archivos | Nativo (secuencial, indexado) | Librerías | Librerías |
| Concurrencia | CICS, batch | async/await | Threads |
| Año de creación | 1959 | 1991 | 1995 |

---

## 5. GnuCOBOL: COBOL Open Source

**GnuCOBOL** (antes OpenCOBOL) es un compilador COBOL open source que:

- ✅ Traduce COBOL a C y luego compila con GCC
- ✅ Implementa COBOL 85 + extensiones 2002/2014
- ✅ **Gratuito** (GPL) — sin licencias de IBM/Micro Focus
- ✅ Multiplataforma: Linux, macOS, Windows
- ✅ Soporta SQL embebido, archivos indexados, SORT

```bash
# Verificar versión en el contenedor Docker
docker compose exec cobol bash -c "cobc --version"
# GnuCOBOL 3.2.0
```

---

## ✅ Checklist de Verificación

- [ ] Nombrar año de creación de COBOL y el comité que lo creó
- [ ] Enumerar al menos 3 industrias donde COBOL es crítico
- [ ] Diferenciar COBOL-68, COBOL-85 y COBOL 2002
- [ ] Explicar por qué COBOL sigue vigente (al menos 2 razones)
- [ ] Identificar qué es GnuCOBOL y por qué lo usamos

## 📚 Recursos

- [GnuCOBOL Programmer's Guide](https://gnucobol.sourceforge.io/HTML/gnucobpg.html)
- [COBOL Programming Course (Open Mainframe Project)](https://github.com/openmainframeproject/cobol-programming-course)
- [The COBOL Chronicles (YouTube)](https://www.youtube.com/results?search_query=cobol+history+grace+hopper)
