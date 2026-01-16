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
('compañero trabajo', 50000, 5, 0, 0),
('pareja', 0, 0, 50000, 1);


select * from finanzas_personales ;

-- 1. ¿A quién(es) le debo más dinero y cuánto?
SELECT nombre, le_debo
FROM finanzas_personales
WHERE le_debo = (SELECT MAX(le_debo) FROM finanzas_personales);

-- 2. ¿Quién(es) me debe(n) más dinero y cuánto?
SELECT nombre, me_debe FROM finanzas_personales WHERE me_debe = (SELECT MAX(me_debe) FROM finanzas_personales);

-- 3. ¿Cuánto dinero debo en total?
SELECT SUM(le_debo) AS total_deuda FROM finanzas_personales;

-- 4. ¿Cuánto dinero debo en promedio?
SELECT AVG(le_debo) AS promedio_deuda FROM finanzas_personales;

-- 5. ¿Cuántos meses demoraría en saldar mi deuda si solo puedo pagar una cuota al mes?
SELECT SUM(cuotas_paga) AS total_meses_para_pagar FROM finanzas_personales;

-- 6. Si cobro todo lo que me deben y lo uso para pagar mi deuda, ¿a cuánto asciende mi nueva deuda reducida?
SELECT SUM(le_debo) - SUM(me_debe) AS nueva_deuda FROM finanzas_personales;

-- 6b. ¿Cuánto tendría que pagar mensualmente para pagar lo que resta en las cuotas ya acordadas?
SELECT
  (SUM(le_debo) - SUM(me_debe))::decimal / SUM(cuotas_paga) AS cuota_mensual
FROM finanzas_personales;

-- 7. Insertar un nuevo registro: deuda con mi pareja
INSERT INTO finanzas_personales (nombre, me_debe, cuotas_cobra, le_debo, cuotas_paga)
VALUES ('pareja', 0, 0, 50000, 1);

-- 8. ¿De cuánto será la cuota a pagar este mes (después de agregar la deuda con mi pareja)?
SELECT SUM(le_debo::decimal / cuotas_paga) AS cuota_total_mes
FROM finanzas_personales
WHERE cuotas_paga > 0;

-- 9. Actualizar las cuotas del almacén esquina a 13
UPDATE finanzas_personales
SET cuotas_paga = 13
WHERE nombre = 'almacen esquina';

-- 10. ¿De cuánto será la cuota a pagar este mes después del ajuste?
SELECT SUM(le_debo::decimal / cuotas_paga) AS cuota_total_mes
FROM finanzas_personales
WHERE cuotas_paga > 0;
