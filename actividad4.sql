DROP TABLE IF EXISTS finanzas_personales;

CREATE TABLE finanzas_personales (
    nombre VARCHAR(30) PRIMARY KEY,
    me_debe INT,
    cuotas_cobra INT,
    le_debo INT,
    cuotas_paga INT
);

INSERT INTO finanzas_personales (nombre, me_debe, cuotas_cobra, le_debo, cuotas_paga) VALUES
('tia carmen', 0, 0, 5000, 1),
('papa', 0, 0, 15000, 3),
('nacho', 10000, 2, 7000, 1),
('almacen esquina', 0, 0, 13000, 2),
('vicios varios', 0, 0, 35000, 35),
('compañero trabajo', 50000, 5, 0, 0);


select * from finanzas_personales ;
