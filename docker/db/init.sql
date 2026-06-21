-- ============================================
-- INIT SQL - bc-cobol Bootcamp
-- Tablas para ejercicios de SQL Embebido
-- Semanas 11+
-- ============================================

-- Clientes bancarios
CREATE TABLE IF NOT EXISTS CLIENTES (
    ID_CLIENTE   INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    NOMBRE       VARCHAR(50)  NOT NULL,
    APELLIDO     VARCHAR(50)  NOT NULL,
    EMAIL        VARCHAR(100),
    TELEFONO     VARCHAR(20),
    FECHA_ALTA   DATE         DEFAULT CURRENT_DATE,
    ESTADO       CHAR(1)      DEFAULT 'A'
        CHECK (ESTADO IN ('A', 'I'))
);

-- Cuentas bancarias
CREATE TABLE IF NOT EXISTS CUENTAS (
    ID_CUENTA    INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    ID_CLIENTE   INTEGER      NOT NULL REFERENCES CLIENTES(ID_CLIENTE),
    TIPO_CUENTA  CHAR(2)      NOT NULL DEFAULT 'CC'
        CHECK (TIPO_CUENTA IN ('CC', 'CA', 'PF')),
    SALDO        DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    MONEDA       CHAR(3)      NOT NULL DEFAULT 'USD',
    FECHA_APERTURA DATE       DEFAULT CURRENT_DATE,
    ESTADO       CHAR(1)      DEFAULT 'A'
        CHECK (ESTADO IN ('A', 'C', 'B'))
);

-- Transacciones
CREATE TABLE IF NOT EXISTS TRANSACCIONES (
    ID_TRANSACCION  INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    ID_CUENTA       INTEGER      NOT NULL REFERENCES CUENTAS(ID_CUENTA),
    TIPO            CHAR(1)      NOT NULL
        CHECK (TIPO IN ('D', 'R', 'T')),
    MONTO           DECIMAL(12,2) NOT NULL,
    FECHA           TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    DESCRIPCION     VARCHAR(100)
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_cuentas_cliente ON CUENTAS(ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_transacciones_cuenta ON TRANSACCIONES(ID_CUENTA);
CREATE INDEX IF NOT EXISTS idx_transacciones_fecha ON TRANSACCIONES(FECHA);

-- Datos de prueba
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO) VALUES
    ('Juan',    'Perez',    'juan@email.com',    '555-0101'),
    ('Maria',   'Garcia',   'maria@email.com',   '555-0102'),
    ('Carlos',  'Lopez',    'carlos@email.com',  '555-0103'),
    ('Ana',     'Martinez', 'ana@email.com',     '555-0104'),
    ('Pedro',   'Rodriguez','pedro@email.com',   '555-0105')
ON CONFLICT DO NOTHING;

INSERT INTO CUENTAS (ID_CLIENTE, TIPO_CUENTA, SALDO, MONEDA) VALUES
    (1, 'CC',  15000.50, 'USD'),
    (1, 'CA',   5000.00, 'USD'),
    (2, 'CC',  25000.75, 'USD'),
    (3, 'CC',  10000.00, 'USD'),
    (4, 'PF', 100000.00, 'USD'),
    (5, 'CC',   3500.25, 'USD')
ON CONFLICT DO NOTHING;
