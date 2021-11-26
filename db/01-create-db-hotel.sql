/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ mydb /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE mydb;

DROP TABLE IF EXISTS cuarto;
CREATE TABLE `cuarto` (
  `id` int NOT NULL,
  `piso` varchar(10) NOT NULL,
  `tipo_categoria` varchar(45) NOT NULL,
  `valor` decimal(10,0) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `hotel_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cuarto_hotel_idx` (`hotel_id`),
  CONSTRAINT `fk_cuarto_hotel` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS hotel;
CREATE TABLE `hotel` (
  `id` int NOT NULL,
  `hotel_nombre` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `departamento` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `departamento_UNIQUE` (`departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS huesped;
CREATE TABLE `huesped` (
  `id` int NOT NULL,
  `huesped_nombre` varchar(45) NOT NULL,
  `nacionalidad` varchar(45) NOT NULL,
  `dni` varchar(45) DEFAULT NULL,
  `telefonos` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `codigo` varchar(8) NOT NULL,
  `pasaporte` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`huesped_nombre`),
  UNIQUE KEY `dni_UNIQUE` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS registro;
CREATE TABLE `registro` (
  `id` int NOT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  `reserva_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_registro_reserva1_idx` (`reserva_id`),
  CONSTRAINT `fk_registro_reserva1` FOREIGN KEY (`reserva_id`) REFERENCES `reserva` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS reserva;
CREATE TABLE `reserva` (
  `id` int NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_reserva` date NOT NULL,
  `cantidad_dias` int NOT NULL,
  `cuarto_id` int NOT NULL,
  `huesped_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reserva_cuarto1_idx` (`cuarto_id`),
  KEY `fk_reserva_huesped1_idx` (`huesped_id`),
  CONSTRAINT `fk_reserva_cuarto1` FOREIGN KEY (`cuarto_id`) REFERENCES `cuarto` (`id`),
  CONSTRAINT `fk_reserva_huesped1` FOREIGN KEY (`huesped_id`) REFERENCES `huesped` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO cuarto(id,piso,tipo_categoria,valor,descripcion,hotel_id) VALUES(1,'2','Estandar',500,'TV, aire acondicionado, frigobar, hidromasaje',1),(2,'4','Lujo',1000,' aire acondicionado, frigobar, hidromasaje,Cajas fuertes electrónicas',2),(3,'9','Super Lujo',4000,'balcón privadoV, aire acondicionado, frigobar, hidromasaje.TV',1),(32,'10','Estandar',1230,'TV, aire acondicionado, frigobar, hidromasaje',2),(50,'20','Lujo',20000,'TV, aire acondicionado, frigobar, hidromasaje',2),(100,'3','Estandar',700,'TV, aire acondicionado, frigobar, hidromasaje',2);

INSERT INTO hotel(id,hotel_nombre,direccion,departamento) VALUES(1,'Think Hotel','AV. GUADALUPE S/N\t','LA PALMA'),(2,'Hotel Campus','AVENIDA NIÑOS HEROES NO. 3','BOXTHA CHICO');

INSERT INTO huesped(id,huesped_nombre,nacionalidad,dni,telefonos,email,codigo,pasaporte) VALUES(1,'Luis Alberto Ccalluchi ','peruana','72430358','938296302','daprimovaria@gmail.com','1234',NULL),(2,'Luis Clifford Vilchez','venezolano',NULL,'987654321','cliffordluis@gmail.com','4321','456328'),(3,'Jerry J. Stillwell','estadounidense',NULL,'9074869747','JerryJStillwell@superrito.com','686','2509645016'),(4,'Anika Calderon','peruana','89765432','987654312,976543218','anikacalshow@gmail.com','2134',NULL),(5,'E Tsui','chino',NULL,'5615337848','ETsui@gustr.com','4485','32232955');


INSERT INTO reserva(id,fecha_inicio,fecha_reserva,cantidad_dias,cuarto_id,huesped_id) VALUES(1,'2021-11-09','2021-11-07',4,32,1),(2,'2021-11-03','2020-11-04',2,100,1),(3,'2021-12-08','2021-11-09',3,32,1),(4,'2021-10-14','2021-08-19',6,100,5),(5,'2023-11-25','2021-11-26',10,32,5);DROP PROCEDURE IF EXISTS buscarHoteles;
CREATE PROCEDURE `buscarHoteles`(IN dp VARCHAR(30))
BEGIN
    SELECT *
    FROM hotel
   WHERE departamento = dp;
END;

DROP PROCEDURE IF EXISTS searchClientById;
CREATE PROCEDURE `searchClientById`(IN DNI VARCHAR(30))
BEGIN
    SELECT huesped.huesped_nombre, hotel.hotel_nombre, hotel.departamento, cuarto.tipo_categoria, cuarto.piso
    FROM huesped
		 INNER JOIN reserva ON (huesped.id =reserva.huesped_id AND huesped.dni=DNI )
         INNER JOIN hotel ON hotel.id = reserva.id
         INNER JOIN cuarto ON cuarto.id = reserva.cuarto_id ;
END;
