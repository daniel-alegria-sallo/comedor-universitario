use EstudiantesDB;
go

CREATE FUNCTION fnAsistencia()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
);
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


CREATE FUNCTION fnAsistenciaPorEstudianteyPeriodo(@Id_Estudiante VARCHAR(50),@Periodo VARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Id_Estudiante = @Id_Estudiante and Periodo=@Periodo
);
go

CREATE FUNCTION fnAsistenciaPorEstudianteyPeriodoyFecha(@Id_Estudiante VARCHAR(50),@Periodo VARCHAR(10), @Fecha DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Id_Estudiante = @Id_Estudiante and Periodo=@Periodo and Fecha=@Fecha
);
go

CREATE FUNCTION fnAsistenciaPorEstudianteyPeriodoyRangoFechas(@Estudiante Varchar(50), @Periodo Varchar(10), @FechaInicio DATE, @FechaFin DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Id_Estudiante=@Estudiante and (Fecha BETWEEN @FechaInicio AND @FechaFin) and Periodo=@Periodo
);
go

CREATE FUNCTION fnAsistenciaPorPeriodoyRangoFechas(@Periodo Varchar(10), @FechaInicio DATE, @FechaFin DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE (Fecha BETWEEN @FechaInicio AND @FechaFin) and Periodo=@Periodo
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

CREATE FUNCTION fnAsistenciaPorEstudianteyFecha(@Estudiante Varchar(50), @Fecha DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Id_Estudiante=@Estudiante and Fecha=@Fecha
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

CREATE FUNCTION fnAsistenciaPorPeriodoyFecha(@Periodo VARCHAR(10), @Fecha DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM t_asistencia
    WHERE Periodo=@Periodo and Fecha=@Fecha
);
go

