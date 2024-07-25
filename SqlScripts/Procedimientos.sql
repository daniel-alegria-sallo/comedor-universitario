use EstudiantesDB;
go

Drop Procedure spRegistrarAsistencia;
go

CREATE PROCEDURE spRegistrarAsistencia
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

Drop Procedure spRealizarReserva;
go
CREATE PROCEDURE spRealizarReserva (
    @Usuario VARCHAR(50),
    @Contraseña VARCHAR(50)
)
AS
BEGIN
    -- Verificar si el usuario ya existe en T_Inscrito
    IF NOT EXISTS (
        SELECT 1
        FROM T_Inscrito
        WHERE Id_Estudiante = @Usuario
    )
    BEGIN
        -- Insertar en T_Inscrito solo si el usuario no existe
        INSERT INTO T_Inscrito (Id_Estudiante, Apellidos, Nombres)
        SELECT Id_Estudiante, Apellidos, Nombres
        FROM T_Estudiante
        WHERE Id_Estudiante = @Usuario;
    END
END;
go
