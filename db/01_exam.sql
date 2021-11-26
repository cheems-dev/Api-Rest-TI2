/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ exam-01 /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE exam-01;

DROP TABLE IF EXISTS album;
CREATE TABLE `album` (
  `id` int NOT NULL,
  `titulo` varchar(45) NOT NULL,
  `descripcion` text NOT NULL,
  `vistas` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS comentario;
CREATE TABLE `comentario` (
  `id` int NOT NULL,
  `fecha` date NOT NULL,
  `contenido` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS foto;
CREATE TABLE `foto` (
  `id` int NOT NULL,
  `id_album` int NOT NULL,
  `id_pais` int NOT NULL,
  `id_tag` int NOT NULL,
  `titulo` varchar(45) NOT NULL,
  `descripcion` text NOT NULL,
  `activo` tinyint NOT NULL,
  `fecha_publicacion` date NOT NULL,
  `vistas` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_foto_album1_idx` (`id_album`),
  KEY `fk_foto_pais1_idx` (`id_pais`),
  KEY `fk_foto_tag1_idx` (`id_tag`),
  CONSTRAINT `fk_foto_album1` FOREIGN KEY (`id_album`) REFERENCES `album` (`id`),
  CONSTRAINT `fk_foto_pais1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id`),
  CONSTRAINT `fk_foto_tag1` FOREIGN KEY (`id_tag`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS foto_comentario;
CREATE TABLE `foto_comentario` (
  `id_foto` int NOT NULL,
  `id_comentario` int NOT NULL,
  PRIMARY KEY (`id_foto`,`id_comentario`),
  KEY `fk_foto_has_comentarios_comentarios1_idx` (`id_comentario`),
  KEY `fk_foto_has_comentarios_foto_idx` (`id_foto`),
  CONSTRAINT `fk_foto_has_comentarios_comentarios1` FOREIGN KEY (`id_comentario`) REFERENCES `comentario` (`id`),
  CONSTRAINT `fk_foto_has_comentarios_foto` FOREIGN KEY (`id_foto`) REFERENCES `foto` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS pais;
CREATE TABLE `pais` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS tag;
CREATE TABLE `tag` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




