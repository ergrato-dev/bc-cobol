# 3-proyecto — Semana 05: Catálogo de Productos Bancarios

## 🎯 Objetivo

Crear un sistema CRUD de catálogo de productos bancarios usando archivo indexado con claves primaria y alterna, ACCESS MODE DYNAMIC, y todas las operaciones: consultar, agregar, modificar, eliminar y listar.

## 📋 Requisitos

1. ✅ Archivo indexado con RECORD KEY (ID) y ALTERNATE RECORD KEY (tipo)
2. ✅ Menu con opciones: Consultar, Agregar, Modificar precio, Eliminar, Listar, Listar por tipo
3. ✅ Usar ACCESS MODE IS DYNAMIC
4. ✅ FILE STATUS con 88-level para cada código (00, 22, 23)
5. ✅ START + READ NEXT para listar desde un ID
6. ✅ Validar duplicados al agregar
7. ✅ Programas separados: `crear-catalogo.cbl` (crea datos iniciales) y el CRUD

## 🗂️ Archivos

```
starter/
├── crear-catalogo.cbl    # Crear y poblar catalogo.idx (ya implementado)
├── catalogo-crud.cbl     # CRUD con TODOs
└── README.md
```

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-05-archivos-indexados/3-proyecto/starter
cobc -x -free crear-catalogo.cbl && ./crear-catalogo
cobc -x -free catalogo-crud.cbl && ./catalogo-crud
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores | Obligatorio |
| RECORD KEY + ALTERNATE KEY correctos | 10% |
| Consulta por ID | 15% |
| Agregar con validación de duplicado | 15% |
| Modificar con REWRITE | 15% |
| Eliminar con DELETE | 10% |
| Listar rango con START | 15% |
| FILE STATUS en todas las operaciones | 10% |
| Código organizado en párrafos | 10% |
