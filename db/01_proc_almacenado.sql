USE mydb;

/* Reciba el código de un departamento y muestre el nombre del departamento y nombre de los hoteles que se encuentren en ese departamento. */
DROP Procedure if exists buscarHoteles;
DELIMITER $$
CREATE PROCEDURE buscarHoteles(IN dp VARCHAR(30))
BEGIN
    SELECT *
    FROM hotel
   WHERE departamento = dp;
END$$
DELIMITER ;

CALL buscarHoteles('LA PALMA');


/* Reciba el DNI de un cliente nacional y muestre el nombre del cliente, hotel(es) y cuarto(s) que reservó. */
DROP Procedure if exists searchClientByDni;
DELIMITER $$
CREATE PROCEDURE searchClientByDni(IN DNI VARCHAR(30))
BEGIN
    SELECT huesped.huesped_nombre, huesped.nacionalidad, hotel.hotel_nombre, hotel.departamento, cuarto.tipo_categoria, cuarto.piso
    FROM huesped
		 INNER JOIN reserva ON (huesped.id = reserva.huesped_id AND huesped.dni = DNI )
         INNER JOIN cuarto ON cuarto.id = reserva.cuarto_id
         INNER JOIN hotel ON hotel.id = cuarto.hotel_id ;
END$$
DELIMITER ;

CALL searchClientByDni('72430358');

/* Reciba el pasaporte de un cliente internacional y muestre el nombre del cliente, hotel(es) y cuarto(s) que alquiló. */

DROP Procedure if exists searchClientByPassport;
DELIMITER $$
CREATE PROCEDURE searchClientByPassport(IN PASS VARCHAR(30))
BEGIN
    SELECT huesped.huesped_nombre, huesped.nacionalidad,hotel.hotel_nombre, hotel.departamento, cuarto.tipo_categoria, cuarto.piso
    FROM huesped
		 INNER JOIN reserva ON (huesped.id = reserva.huesped_id AND huesped.pasaporte = PASS)
         INNER JOIN cuarto ON cuarto.id = reserva.cuarto_id
         INNER JOIN hotel ON hotel.id = cuarto.hotel_id
END$$
DELIMITER ;

CALL searchClientByPassport('32232955');
