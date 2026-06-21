       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Ficha de Empleado
      *> Semana 02 - DATA DIVISION
      *> ============================================
      *>
      *> Implementa cada TODO usando lo aprendido en
      *> PICTURE, USAGE, VALUE, niveles y 88-level.
      *>
      *> Compilar: cobc -x -free ficha-empleado.cbl
      *> Ejecutar: ./ficha-empleado

       IDENTIFICATION DIVISION.
       PROGRAM-ID. FICHAEMP.
       AUTHOR. ESTUDIANTE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === SEPARADORES (ya implementados) ===
       01  WS-SEPARADOR    PIC X(50) VALUE ALL "=".
       01  WS-SUBSEP       PIC X(50) VALUE ALL "-".

      *> ============================================
      *> TODO 1: DISEÑAR REGISTRO JERÁRQUICO DE EMPLEADO
      *> ============================================
      *> Crea un registro con niveles 01 → 05 → 10.
      *> Campos requeridos:
      *>   - ID empleado (5 dígitos)
      *>   - Nombre completo (subgrupo con primer nombre + apellido)
      *>   - Fecha de ingreso (subgrupo con año, mes, día)
      *>   - Salario mensual (9 dígitos, 2 decimales, con signo)
      *>   - Departamento (código de 2 dígitos)
      *>   - Tipo de contrato (1 carácter: P=Permanente, T=Temporal)
      *>   - Estado (1 carácter: A=Activo, I=Inactivo, V=Vacaciones)
      *>
      *> Pista: usa PIC X(n) para texto, PIC 9(n) para números,
      *>        PIC S9(n)V99 para salario con signo y decimales.
      *>        Para FECHA-INGRESO crea un subgrupo con ANO, MES, DIA.
      *>
      *> Descomenta y completa:
      *01  EMPLEADO.
      *    *> TODO: nivel 05 EMP-ID con PIC adecuado
      *    *> TODO: nivel 05 EMP-NOMBRE (subgrupo)
      *    *>        nivel 10 EMP-PRIMER-NOMBRE
      *    *>        nivel 10 EMP-APELLIDO
      *    *> TODO: nivel 05 EMP-FECHA-INGRESO (subgrupo)
      *    *>        nivel 10 EMP-ANO-ING
      *    *>        nivel 10 EMP-MES-ING
      *    *>        nivel 10 EMP-DIA-ING
      *    *> TODO: nivel 05 EMP-SALARIO-MENSUAL con PIC S9(07)V99
      *    *> TODO: nivel 05 EMP-DEPTO con PIC 9(02)
      *    *> TODO: nivel 05 EMP-TIPO-CONTRATO con PIC X(01)
      *    *> TODO: nivel 05 EMP-ESTADO con PIC X(01)

      *> ============================================
      *> TODO 2: 88-LEVEL PARA ESTADOS
      *> ============================================
      *> Crea condition names para:
      *>   EMP-ACTIVO      → "A"
      *>   EMP-INACTIVO    → "I"
      *>   EMP-VACACIONES  → "V"
      *>   EMP-PERMANENTE  → "P"
      *>   EMP-TEMPORAL    → "T"
      *>   DEPTO-VALIDO    → 1 THRU 5
      *>
      *> Descomenta y completa:
      *    88 EMP-ACTIVO        VALUE "A".
      *    88 EMP-INACTIVO      VALUE "I".
      *    88 EMP-VACACIONES    VALUE "V".
      *    88 EMP-PERMANENTE    VALUE "P".
      *    88 EMP-TEMPORAL      VALUE "T".
      *    88 DEPTO-VALIDO       VALUE 1 THRU 5.

      *> ============================================
      *> TODO 3: CAMPOS DE EDICIÓN
      *> ============================================
      *> Crea campos para mostrar en pantalla con formato:
      *>   - Salario mensual en formato moneda ($)
      *>   - Salario anual en formato moneda ($)
      *>   - Fecha de ingreso en formato 99/99/9999
      *>
      *> Descomenta y completa:
      *01  WS-SALARIO-EDIT    PIC $$,$$9.99.
      *01  WS-SALARIO-ANUAL-EDIT PIC $$,$$9.99.
      *01  WS-FECHA-EDIT      PIC 99/99/9999.

      *> ============================================
      *> TODO 4: VARIABLES DE CÁLCULO
      *> ============================================
      *> Crea variables para:
      *>   - Salario anual (12 meses) - usa COMP-3
      *>   - Bono (10% del salario anual) - usa COMP-3
      *>   - ISR estimado (15% sobre salario anual + bono) - usa COMP-3
      *>
      *> Descomenta y completa:
      *01  WS-SALARIO-ANUAL   PIC S9(09)V99 USAGE COMP-3.
      *01  WS-BONO            PIC S9(07)V99 USAGE COMP-3.
      *01  WS-ISR             PIC S9(07)V99 USAGE COMP-3.

       PROCEDURE DIVISION.
       MAIN.

      *> ============================================
      *> TODO 5: ASIGNAR DATOS DE PRUEBA
      *> ============================================
      *> Asigna un empleado de ejemplo:
      *>   ID: 1042
      *>   Nombre: "Laura", Apellido: "Fernandez"
      *>   Fecha ingreso: 15 de marzo 2019
      *>   Salario: $45,500.75
      *>   Departamento: 3
      *>   Contrato: Permanente
      *>   Estado: Activo
      *>
      *> Descomenta y completa:
      *    MOVE 1042 TO *> TODO: completar
      *    MOVE "Laura" TO *> TODO: completar
      *    MOVE "Fernandez" TO *> TODO: completar
      *    MOVE 2019 TO *> TODO: completar
      *    MOVE 03 TO *> TODO: completar
      *    MOVE 15 TO *> TODO: completar
      *    MOVE 45500.75 TO *> TODO: completar
      *    MOVE 3 TO *> TODO: completar
      *    SET EMP-PERMANENTE TO TRUE.        *> Ya implementado
      *    SET EMP-ACTIVO TO TRUE.            *> Ya implementado

      *> ============================================
      *> TODO 6: CALCULAR SALARIO ANUAL, BONO E ISR
      *> ============================================
      *> Salario anual = salario mensual × 12
      *> Bono = salario anual × 0.10
      *> ISR = (salario anual + bono) × 0.15
      *>
      *> Descomenta y completa:
      *    COMPUTE WS-SALARIO-ANUAL = *> TODO: completar
      *    COMPUTE WS-BONO = *> TODO: completar
      *    COMPUTE WS-ISR = *> TODO: completar

      *> ============================================
      *> TODO 7: FORMATEAR CAMPOS DE EDICIÓN
      *> ============================================
      *> Mueve los valores a los campos de edición
      *>
      *> Descomenta y completa:
      *    MOVE *> TODO: salario mensual a campo de edición
      *    MOVE *> TODO: salario anual a campo de edición
      *    MOVE *> TODO: fecha ingreso a campo de edición

      *> ============================================
      *> TODO 8: MOSTRAR FICHA DE EMPLEADO
      *> ============================================
      *> Muestra todos los datos formateados profesionalmente
      *> Usa 88-level para mostrar estado y tipo de contrato
      *>
      *> Descomenta y completa:
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY "         FICHA DE EMPLEADO".
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY " ".
      *    DISPLAY "ID           : " *> TODO: EMP-ID
      *    DISPLAY "Nombre       : " *> TODO: EMP-PRIMER-NOMBRE " " EMP-APELLIDO
      *    DISPLAY "Fecha Ingreso: " *> TODO: WS-FECHA-EDIT
      *    DISPLAY "Departamento : " *> TODO: EMP-DEPTO
      *    DISPLAY WS-SUBSEP.
      *    DISPLAY "Salario Mensual: " *> TODO: WS-SALARIO-EDIT
      *    DISPLAY "Salario Anual  : " *> TODO: WS-SALARIO-ANUAL-EDIT
      *    DISPLAY "Bono (10%)     : " *> TODO: WS-BONO
      *    DISPLAY "ISR (15%)      : " *> TODO: WS-ISR
      *    DISPLAY WS-SUBSEP.

      *> Mostrar estado y tipo de contrato usando 88-level
      *    IF EMP-ACTIVO
      *        DISPLAY "Estado        : ACTIVO"
      *    END-IF.
      *    IF EMP-PERMANENTE
      *        DISPLAY "Tipo Contrato : PERMANENTE"
      *    END-IF.
      *    IF DEPTO-VALIDO
      *        DISPLAY "Departamento  : VALIDO"
      *    END-IF.
      *    DISPLAY " ".
           STOP RUN.

      *> ============================================
      *> RESULTADO ESPERADO (completo)
      *> ============================================
      *> ==================================================
      *>          FICHA DE EMPLEADO
      *> ==================================================
      *>
      *> ID           : 01042
      *> Nombre       : Laura Fernandez
      *> Fecha Ingreso: 15/03/2019
      *> Departamento : 03
      *> --------------------------------------------------
      *> Salario Mensual: $ 45,500.75
      *> Salario Anual  : $546,009.00
      *> Bono (10%)     : $ 54,600.90
      *> ISR (15%)      : $ 90,091.48
      *> --------------------------------------------------
      *> Estado        : ACTIVO
      *> Tipo Contrato : PERMANENTE
      *> Departamento  : VALIDO
