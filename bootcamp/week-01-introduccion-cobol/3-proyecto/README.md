# 3-proyecto — Semana 01: Presentación Personal

## 🎯 Objetivo del Proyecto

Crear un programa COBOL que solicite datos personales al usuario y genere una presentación formateada profesionalmente.

## 📋 Requisitos

El programa debe:

1. ✅ Mostrar un encabezado con título del sistema
2. ✅ Solicitar: nombre, apellido, edad, ciudad y profesión
3. ✅ Validar que los campos no estén vacíos (nombre y apellido)
4. ✅ Mostrar una **tarjeta de presentación** formateada
5. ✅ Mostrar un mensaje de despedida personalizado

## 🗂️ Archivos

```
3-proyecto/
├── README.md           # Este archivo
└── starter/
    └── presentacion.cbl # Código inicial con TODOs
```

## 🚀 Cómo Ejecutar

Dentro del contenedor Docker:

```bash
docker compose exec cobol bash
cd bootcamp/week-01-introduccion-cobol/3-proyecto/starter
cobc -x -free presentacion.cbl
./presentacion
```

## 📝 Instrucciones

1. Lee el código en `starter/presentacion.cbl`
2. Completa cada `TODO` implementando la lógica solicitada
3. Cada TODO tiene una descripción de lo que debe hacer
4. Usa lo aprendido en teoría y prácticas:
   - DISPLAY y ACCEPT para entrada/salida
   - MOVE para asignar valores
   - IF para validaciones
   - PERFORM para organizar el código en párrafos

## 🎨 Formato de Salida Esperado

```
╔══════════════════════════════════════════════╗
║        SISTEMA DE REGISTRO PROFESIONAL       ║
╚══════════════════════════════════════════════╝

Ingrese su nombre   : Juan
Ingrese su apellido : Perez
Ingrese su edad     : 28
Ingrese su ciudad   : Buenos Aires
Ingrese su profesion: Desarrollador COBOL

╔══════════════════════════════════════════════╗
║          TARJETA DE PRESENTACION             ║
╠══════════════════════════════════════════════╣
║                                              ║
║   Nombre   : Juan Perez                      ║
║   Edad     : 28 años                         ║
║   Ciudad   : Buenos Aires                    ║
║   Profesion: Desarrollador COBOL             ║
║                                              ║
╚══════════════════════════════════════════════╝

Gracias por registrarte, Juan!
Bienvenido al Bootcamp COBOL Zero to Hero.
```

## 📊 Criterios de Evaluación

| Criterio | Peso | Descripción |
|----------|------|-------------|
| Compilación | Obligatorio | `cobc -x -free` sin errores |
| Entrada de datos | 25% | Solicita y lee todos los campos |
| Validación | 20% | Verifica que nombre y apellido no estén vacíos |
| Presentación | 25% | Tarjeta formateada con bordes y alineación |
| Código limpio | 15% | Párrafos organizados, indentación correcta |
| Comentarios | 15% | Código documentado con `*> ` |
