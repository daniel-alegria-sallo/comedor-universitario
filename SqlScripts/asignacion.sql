CREATE FUNCTION spAsignacion
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

