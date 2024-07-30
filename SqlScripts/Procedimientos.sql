use EstudiantesDB;
go

Drop Procedure spRegistrarAsistencia;
go

CREATE PROCEDURE spIncribirEstudiate
    @IdEstudiante VARCHAR(10)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM T_Inscrito WHERE Id_Estudiante = @IdEstudiante)
    BEGIN
        INSERT INTO T_Asistencia (Id_Estudiante, Fecha)
        VALUES (@IdEstudiante, GETDATE());
    END
END;
go

Drop Procedure spIncribirEstudiante;
go

CREATE PROCEDURE spIncribirEstudiante (
    @Usuario VARCHAR(50),
    @Contraseña VARCHAR(50),
    @Periodo VARCHAR(50)
)
AS
BEGIN
    -- Verificar si existe el Usuario del estudiante
    IF NOT EXISTS (
        SELECT 1
        FROM T_Estudiante TE
        INNER JOIN T_Usuario TU ON TE.Id_Estudiante = TU.Id_Estudiante
        WHERE @Usuario = TU.Id_Estudiante AND @Contraseña = TU.Contraseña
    )
    BEGIN
        IF NOT EXISTS (
            SELECT 1
            FROM T_Inscrito
            WHERE @Usuario = Id_Estudiante AND Periodo = @Periodo
        )
        BEGIN
            -- Insertar en T_Inscrito solo si el usuario no existe
            INSERT INTO T_Inscrito (Id_Estudiante, apellidos, nombres, Periodo)
            SELECT Id_Estudiante, apellidos, nombres, @Periodo
            FROM T_Estudiante
            WHERE Id_Estudiante = @Usuario;
        END
    END
END;

