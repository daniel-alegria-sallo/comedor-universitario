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

Drop Procedure spInscribirEstudiante;
go
CREATE PROCEDURE spInscribirEstudiante (
    @Usuario VARCHAR(50),
    @contraseña VARCHAR(50),
    @Periodo VARCHAR(50)
)
AS
BEGIN
    -- Verificar si existe el Usuario del estudiante
    IF EXISTS (
        SELECT 1
        FROM T_Estudiante TE
        INNER JOIN T_Usuario TU ON TE.Id_Estudiante = TU.Id_Estudiante
        WHERE @Usuario = TU.Id_Estudiante AND @contraseña = TU.contraseña
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
    ELSE
      Print 'ERROR. ';
    END


END;

-- Drop Procedure spPagar;
-- go
-- CREATE PROCEDURE spPagar
--     @IdEstudiante VARCHAR(10)
-- AS
-- BEGIN
--     -- UPDATE T_Asignados WHERE Id_Estudiante = @IdEstudiante
--
--     -- IF EXISTS (SELECT 1 FROM T_Seleccionados WHERE Id_Estudiante = @IdEstudiante)
--     -- BEGIN
--     --     INSERT INTO T_Matriculados (Id_Estudiante)
--     --     VALUES (@IdEstudiante);
--     -- END
-- END;
-- go
--
