USE universidad;

/* • Reciba el código de un profesor y muestre, el nombre del profesor, código(s) del(os) alumno(s) y nombre(s) del(os) alumno(s) del cual el profesor es tutor. */
DROP Procedure if exists getTeacher;
DELIMITER $$
CREATE PROCEDURE getTeacher(IN CODIGO integer)
BEGIN
    SELECT Profesor.nombre, Alumno.id, Alumno.nombre, Alumno.email
    FROM Profesor
		INNER JOIN Alumno ON (Profesor.id = Alumno.Profesor_id AND Profesor.id = CODIGO )
   ;
END$$
DELIMITER ;

CALL getTeacher(2);


/* • Reciba el código del proyecto y muestre, el código y nombre del profesor que es investigador principal */
DROP Procedure if exists getInvestigadorPrincipal;
DELIMITER $$
CREATE PROCEDURE getInvestigadorPrincipal(IN CODIGO integer)
BEGIN
    SELECT
		ProyectoInvestigacion.tipo_proyecto,
		ProyectoInvestigacion.presupuesto,
        Investigador_Principal.id,
        Investigador_Principal.nombre,
        Investigador_Principal.email

    FROM ProyectoInvestigacion
		INNER JOIN Investigador_Principal
        ON (Investigador_Principal.id = ProyectoInvestigacion.Investigador_Principal_id AND ProyectoInvestigacion.codigo = CODIGO )
   ;
END$$
DELIMITER ;
CALL getInvestigadorPrincipal(1);

/* Reciba el código del alumno no becario y muestre, la pensión que debe pagar */

DROP Procedure if exists getEstNoBecario;
DELIMITER $$
CREATE PROCEDURE getEstNoBecario(IN CODIGO integer)
BEGIN
    SELECT
		Alumno.nombre,
		Alumno.edad,
        Alumno.pension
    FROM Alumno
        WHERE Alumno.pension != 0 AND Alumno.id = CODIGO
   ;
END$$
DELIMITER ;
CALL getEstNoBecario(1);
