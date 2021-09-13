use SVOlanoSAC;

/*
DROP TRIGGER kardex_ingreso;
DROP TRIGGER kardex_egreso;
DROP PROCEDURE ventas_x_mes;
DROP PROCEDURE productos_mas_vendidos;
DROP PROCEDURE actualizar;
DROP PROCEDURE compras_x_mes;
*/

DELIMITER $$
CREATE TRIGGER kardex_ingreso AFTER INSERT ON detalle_compra FOR EACH ROW
BEGIN
	DECLARE cantidad BIGINT;
    DECLARE valor_promedio FLOAT(8,2);
    DECLARE v_total FLOAT(12,2);
    DECLARE cantidad_total FLOAT(12,2);
    DECLARE xMargen FLOAT(4,2);

    SET xMargen = (SELECT margen / 100 FROM empresa);

    SET cantidad = (SELECT COUNT(*) FROM kardex WHERE producto_id = NEW.producto_id);

    IF cantidad = 0 THEN
		UPDATE producto SET precio_compra = NEW.precio, precio_venta = ROUND(NEW.precio/(1 - xMargen),1),stock = (stock + NEW.cantidad) WHERE id_producto = NEW.producto_id;

		INSERT INTO kardex(fecha,producto_id,operacion,nrodocumento,valor_unitario,cantidad,valor,stock_total,valor_total)
		VALUES(CURDATE(),NEW.producto_id,'Compra',NEW.compra_id,NEW.precio,NEW.cantidad,NEW.precio,NEW.cantidad,(NEW.precio * NEW.cantidad));
    ELSE
		SET v_total = (SELECT valor_total FROM kardex WHERE producto_id = NEW.producto_id ORDER BY id_kardex DESC LIMIT 1);
        SET v_total = (v_total + (NEW.precio * NEW.cantidad));
        SET valor_promedio = (SELECT valor_unitario FROM kardex WHERE producto_id = NEW.producto_id ORDER BY id_kardex DESC LIMIT 1);
        SET valor_promedio = ROUND((CAST(valor_promedio AS DECIMAL(8,2)) + CAST(NEW.precio AS DECIMAL(8,2))) / 2,1);
        SET cantidad_total = (SELECT stock_total FROM kardex WHERE producto_id = NEW.producto_id ORDER BY id_kardex DESC LIMIT 1);
        SET cantidad_total = (cantidad_total + NEW.cantidad);
        UPDATE producto SET precio_compra = valor_promedio, precio_venta = ROUND(valor_promedio/(1 - xMargen),1),stock = (stock + NEW.cantidad) WHERE id_producto = NEW.producto_id;

		INSERT INTO kardex(fecha,producto_id,operacion,nrodocumento,valor_unitario,cantidad,valor,stock_total,valor_total)
		VALUES(CURDATE(),NEW.producto_id,'Compra',NEW.compra_id,valor_promedio,NEW.cantidad,NEW.precio,cantidad_total,v_total);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER kardex_egreso AFTER INSERT ON detalle_venta FOR EACH ROW
BEGIN
	DECLARE cantidad BIGINT;
    DECLARE valor_promedio FLOAT(8,2);
    DECLARE v_total FLOAT(12,2);
    DECLARE cantidad_total FLOAT(12,2);

    SET cantidad = (SELECT COUNT(*) FROM kardex WHERE producto_id = NEW.producto_id AND operacion = 'Compra');
    UPDATE producto SET stock = (stock - NEW.cantidad) WHERE id_producto = NEW.producto_id;
    SET valor_promedio = (SELECT precio_compra FROM producto WHERE id_producto = NEW.producto_id);
    SET cantidad_total = (SELECT stock FROM producto WHERE id_producto = NEW.producto_id);

    IF cantidad = 0 THEN
		SET v_total = (SELECT precio_compra * stock FROM producto WHERE id_producto = NEW.producto_id);
		INSERT INTO kardex(fecha,producto_id,operacion,nrodocumento,valor_unitario,cantidad,valor,stock_total,valor_total)
		VALUES(CURDATE(),NEW.producto_id,'Venta',NEW.venta_id,valor_promedio,NEW.cantidad,valor_promedio,cantidad_total,v_total);
    ELSE
		SET v_total = (SELECT valor_total FROM kardex WHERE producto_id = NEW.producto_id ORDER BY id_kardex DESC LIMIT 1);
        SET v_total = (v_total - (CAST(valor_promedio AS DECIMAL(8,2)) * NEW.cantidad));
        SET cantidad_total = (cantidad_total - NEW.cantidad);
		INSERT INTO kardex(fecha,producto_id,operacion,nrodocumento,valor_unitario,cantidad,valor,stock_total,valor_total)
		VALUES(CURDATE(),NEW.producto_id,'Venta',NEW.venta_id,valor_promedio,NEW.cantidad,valor_promedio,cantidad_total,v_total);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ventas_x_mes ()
BEGIN
	SELECT YEAR(fecha) as año,MONTH(fecha) as mes,CAST(SUM(total) AS DECIMAL(12,2)) as total
    FROM venta WHERE YEAR(fecha) = DATE_FORMAT(Now(),'%Y') GROUP BY mes,año ORDER BY mes asc;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE productos_mas_vendidos()
BEGIN
	SELECT YEAR(fecha) as año, p.producto, SUM(cantidad) as importe
    FROM venta v inner join detalle_venta d on d.venta_id = v.id_venta
    inner join producto p on p.id_producto = d.producto_id
    WHERE YEAR(fecha) = DATE_FORMAT(Now(),'%Y') GROUP BY año,p.producto ORDER BY importe DESC LIMIT 10;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE actualizar()
BEGIN
	DECLARE new_saldo FLOAT(10,2);
    DECLARE id BIGINT;
    SET new_saldo = (SELECT  sum(c.monto) FROM caja c WHERE c.id_caja);
    SET id = (SELECT id_caja FROM caja ORDER BY id_caja DESC LIMIT 1);
	UPDATE caja SET saldo = new_saldo WHERE id_caja = id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE compras_x_mes()
BEGIN
	SELECT MONTH(fecha) as mes, SUM(total) as monto FROM compra
    WHERE YEAR(fecha) = YEAR(now())
    GROUP BY mes;
END$$
DELIMITER ;
