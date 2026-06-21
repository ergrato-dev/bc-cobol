# 🔒 Política de Seguridad

## Versiones Soportadas

| Versión | Soportada |
| ------- | --------- |
| main    | ✅        |

## Reportar una Vulnerabilidad

La seguridad de este proyecto es importante para nosotros. Si descubres una vulnerabilidad de seguridad, te pedimos que la reportes de manera responsable.

### ⚠️ NO hacer público el reporte

Por favor, **NO** abras un issue público para reportar vulnerabilidades de seguridad.

### 📧 Cómo Reportar

1. **Abre un Security Advisory privado** en GitHub:
   - Ve a la pestaña "Security" del repositorio
   - Haz clic en "Report a vulnerability"
   - Completa el formulario con los detalles

2. **Incluye en tu reporte**:
   - Descripción detallada de la vulnerabilidad
   - Pasos para reproducir el problema
   - Impacto potencial
   - Sugerencias de solución (si las tienes)

### ⏱️ Tiempo de Respuesta

- **Confirmación inicial**: 48 horas
- **Evaluación**: 7 días
- **Resolución**: Dependiendo de la severidad

### 🎁 Reconocimiento

Agradecemos a todos los investigadores de seguridad que reportan vulnerabilidades de manera responsable.

## Mejores Prácticas de Seguridad

Este bootcamp enseña las siguientes prácticas de seguridad:

### Validación de Datos de Entrada

```cobol
*> ✅ Validar longitud antes de STRING
       IF LENGTH OF WS-INPUT-DATA > 80
           MOVE "ERROR: LONGITUD EXCEDIDA" TO WS-MENSAJE
           PERFORM 9999-TERMINAR
       END-IF.
```

### Manejo de Archivos

```cobol
*> ✅ Verificar FILE STATUS después de cada operación
       READ ARCHIVO-CLIENTES
           AT END SET WS-EOF TO TRUE
           NOT AT END PERFORM 2000-PROCESAR-REGISTRO
       END-READ.

*> ✅ FILE STATUS para control de errores
       READ ARCHIVO-CLIENTES
           NOT INVALID KEY PERFORM 9000-ERROR-LECTURA
           NOT AT END PERFORM 2000-PROCESAR-REGISTRO
       END-READ.
```

### SQL Embebido

```cobol
       EXEC SQL
           SELECT NOMBRE, SALDO INTO :WS-NOMBRE, :WS-SALDO
           FROM CLIENTES
           WHERE ID_CLIENTE = :WS-ID-CLIENTE
       END-EXEC.
       
       IF SQLCODE NOT = 0
           PERFORM 9000-SQL-ERROR
       END-IF.
```

### Buenas Prácticas Generales

- Validar todos los datos de entrada
- Usar FILE STATUS para control de errores de archivos
- Implementar manejo de SQLCODE en SQL embebido
- Nunca hardcodear contraseñas o credenciales en código fuente
- Usar parámetros de configuración externos (archivos de control)
- Mantener separación entre datos de prueba y datos reales
