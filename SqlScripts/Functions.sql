use EstudiantesDB;
go

CREATE FUNCTION fnAsistenciaPorEstudiante(@Id_Estudiante VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Id_Estudiante = @Id_Estudiante
);
go


CREATE FUNCTION fnAsistenciaPorEstudianteyPeriodo(@Id_Estudiante VARCHAR(50),@Periodo VARCHAR(5))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Id_Estudiante = @Id_Estudiante and Periodo=@Periodo
);
go



CREATE FUNCTION fnAsistenciaPorPeriodo(@Periodo VARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Periodo = @Periodo
);
go

CREATE FUNCTION fnAsistenciaPorFecha(@Fecha DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Fecha = @Fecha
);
go

CREATE FUNCTION fnAsistenciaPorRangoFechas(@FechaInicio DATE, @FechaFin DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Fecha BETWEEN @FechaInicio AND @FechaFin
);
go

CREATE FUNCTION fnAsistenciaPorEstudianteyRangoFechas(@Estudiante Varchar(50),@FechaInicio DATE, @FechaFin DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Id_Estudiante=@Estudiante and (Fecha BETWEEN @FechaInicio AND @FechaFin)
);
go

