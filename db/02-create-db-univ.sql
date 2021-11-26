/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ universidad /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE universidad;

DROP TABLE IF EXISTS Alumno;
CREATE TABLE `Alumno` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `edad` int NOT NULL,
  `telefono` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `pension` decimal(10,4) NOT NULL,
  `Profesor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  KEY `fk_Alumno_Profesor1_idx` (`Profesor_id`),
  CONSTRAINT `fk_Alumno_Profesor1` FOREIGN KEY (`Profesor_id`) REFERENCES `Profesor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Becario;
CREATE TABLE `Becario` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `edad` int NOT NULL,
  `telefono` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `Profesor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  KEY `fk_Becario_Profesor1_idx` (`Profesor_id`),
  CONSTRAINT `fk_Becario_Profesor1` FOREIGN KEY (`Profesor_id`) REFERENCES `Profesor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Becario_ProyectoInvestigacion;
CREATE TABLE `Becario_ProyectoInvestigacion` (
  `Becario_id` int NOT NULL,
  `Proyecto_Investigacion_codigo` varchar(4) NOT NULL,
  PRIMARY KEY (`Becario_id`,`Proyecto_Investigacion_codigo`),
  KEY `fk_Becario_has_Proyecto_Investigacion_Proyecto_Investigacio_idx` (`Proyecto_Investigacion_codigo`),
  KEY `fk_Becario_has_Proyecto_Investigacion_Becario1_idx` (`Becario_id`),
  CONSTRAINT `fk_Becario_has_Proyecto_Investigacion_Becario1` FOREIGN KEY (`Becario_id`) REFERENCES `Becario` (`id`),
  CONSTRAINT `fk_Becario_has_Proyecto_Investigacion_Proyecto_Investigacion1` FOREIGN KEY (`Proyecto_Investigacion_codigo`) REFERENCES `ProyectoInvestigacion` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Empresa;
CREATE TABLE `Empresa` (
  `codigo` varchar(4) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Hito;
CREATE TABLE `Hito` (
  `codigo` varchar(4) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `presupuesto` int NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Hito_Proyecto;
CREATE TABLE `Hito_Proyecto` (
  `Proyecto_codigo` varchar(4) NOT NULL,
  `Hito_codigo` varchar(4) NOT NULL,
  KEY `fk_Hito_Proyecto_Proyecto1_idx` (`Proyecto_codigo`),
  KEY `fk_Hito_Proyecto_Hito1_idx` (`Hito_codigo`),
  CONSTRAINT `fk_Hito_Proyecto_Hito1` FOREIGN KEY (`Hito_codigo`) REFERENCES `Hito` (`codigo`),
  CONSTRAINT `fk_Hito_Proyecto_Proyecto1` FOREIGN KEY (`Proyecto_codigo`) REFERENCES `ProyectoInvestigacion` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Investigador_Principal;
CREATE TABLE `Investigador_Principal` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `edad` int NOT NULL,
  `especialidad` varchar(45) NOT NULL,
  `telefono` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Profesor;
CREATE TABLE `Profesor` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `edad` int NOT NULL,
  `especialidad` varchar(45) NOT NULL,
  `telefono` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Profesor_ProyectoInvestigacion;
CREATE TABLE `Profesor_ProyectoInvestigacion` (
  `Profesor_id` int NOT NULL,
  `ProyectoInvestigacion_codigo` varchar(4) NOT NULL,
  PRIMARY KEY (`Profesor_id`,`ProyectoInvestigacion_codigo`),
  KEY `fk_Profesor_has_ProyectoInvestigacion_ProyectoInvestigacion_idx` (`ProyectoInvestigacion_codigo`),
  KEY `fk_Profesor_has_ProyectoInvestigacion_Profesor1_idx` (`Profesor_id`),
  CONSTRAINT `fk_Profesor_has_ProyectoInvestigacion_Profesor1` FOREIGN KEY (`Profesor_id`) REFERENCES `Profesor` (`id`),
  CONSTRAINT `fk_Profesor_has_ProyectoInvestigacion_ProyectoInvestigacion1` FOREIGN KEY (`ProyectoInvestigacion_codigo`) REFERENCES `ProyectoInvestigacion` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS ProyectoInvestigacion;
CREATE TABLE `ProyectoInvestigacion` (
  `codigo` varchar(4) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `presupuesto` decimal(10,0) NOT NULL,
  `tipo_proyecto` varchar(45) NOT NULL,
  `Empresa_codigo` varchar(4) DEFAULT NULL,
  `Universidad_codigo` varchar(4) DEFAULT NULL,
  `Investigador_Principal_id` int NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_Proyecto_Empresa_idx` (`Empresa_codigo`),
  KEY `fk_Proyecto_Universidad1_idx` (`Universidad_codigo`),
  KEY `fk_Proyecto_Investigador_Principal1_idx` (`Investigador_Principal_id`),
  CONSTRAINT `fk_Proyecto_Empresa` FOREIGN KEY (`Empresa_codigo`) REFERENCES `Empresa` (`codigo`),
  CONSTRAINT `fk_Proyecto_Investigador_Principal1` FOREIGN KEY (`Investigador_Principal_id`) REFERENCES `Investigador_Principal` (`id`),
  CONSTRAINT `fk_Proyecto_Universidad1` FOREIGN KEY (`Universidad_codigo`) REFERENCES `Universidad` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS Universidad;
CREATE TABLE `Universidad` (
  `codigo` varchar(4) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

INSERT INTO Alumno(id,nombre,fecha_nacimiento,edad,telefono,email,pension,Profesor_id) VALUES(1,'Luis Alberto Ccalluchi','2021-11-10',20,'938296302','daprimovaria@gmail.com',1000.0000,2),(2,'Luis Bustamante','2021-11-18',19,'987654321','bustamante@gmail.com',4000.0000,1),(3,'Angela Sucso','2021-11-24',17,'912345678','angela.sucso@gmail.com',1000.0000,5),(4,'Luis Moroco','2021-11-18',15,'98654321','moroco@gmail.com',2030.0000,3),(5,'Selene Barrios','2021-11-25',20,'987654321','selene@gmail.com',2000.0000,2);

INSERT INTO Becario(id,nombre,fecha_nacimiento,edad,telefono,email,Profesor_id) VALUES(1,'Antonio Sanez','2021-12-10',20,'9845789291','antonio@gmail.com',2),(2,'Angelito Angel','2021-11-29',30,'9234567891','angelito@gmail.com',2),(3,'sweet plumb','2021-11-30',30,'86543234567','plumb@gmail.com',2),(4,'Lana Bunny','2021-12-09',23,'123456789','lana.bunny@gmail.com',4);


INSERT INTO Empresa(codigo,nombre) VALUES('1234','InkaLabs'),('2345','Aceros Arequipa');

INSERT INTO Hito(codigo,fecha_inicio,fecha_fin,presupuesto) VALUES('1234','2021-11-01','2021-12-11',4000);


INSERT INTO Investigador_Principal(id,nombre,fecha_nacimiento,edad,especialidad,telefono,email) VALUES(1,'Carlo Atencio','2021-11-17',20,'Blockchain','12346789','carlo@gmail.com'),(2,'Jorge Antonio','2021-11-09',30,'I.A','987654321','antonio@gmail.com');

INSERT INTO Profesor(id,nombre,fecha_nacimiento,edad,especialidad,telefono,email) VALUES(1,'Franci Suni Lopez','2025-06-01',30,'Ingeneria de Sofware','+19163850525','franci@gmail.com'),(2,'Carlos Atencio','2021-11-02',20,'Blockchain Developer','+447480728290','atenciogod@gmail.com'),(3,'Edson Luque','2021-11-03',20,'Sofware Developer ','+13069884048','edson.luque@gmail.com'),(4,'Javier Carmon','2021-11-04',30,'Sofware Engenier','748 203 537','javier.carmone@gmail.com'),(5,'Regis Barragán Escalante','2021-11-05',40,'Data Science','1Z 186 260 73 ','RegisBarraganEscalante@superrito.com');


INSERT INTO ProyectoInvestigacion(codigo,fecha_inicio,fecha_fin,presupuesto,tipo_proyecto,Empresa_codigo,Universidad_codigo,Investigador_Principal_id) VALUES('1','2021-11-01','2021-11-06',1000000,'Basico',NULL,'2',1),('2','2021-11-07','2021-11-18',200000,'Basico',NULL,'1',1),('3','2021-11-09','2021-12-11',40000,'Aplicada','1234',NULL,2);
INSERT INTO Universidad(codigo,nombre) VALUES('1','UNSA'),('2','UCS');DROP PROCEDURE IF EXISTS getTeacher;
CREATE PROCEDURE `getTeacher`(IN CODIGO integer)
BEGIN
    SELECT Profesor.nombre, Alumno.id, Alumno.nombre, Alumno.email
    FROM Profesor
		INNER JOIN Alumno ON (Profesor.id = Alumno.Profesor_id AND Profesor.id = CODIGO )
   ;
END;