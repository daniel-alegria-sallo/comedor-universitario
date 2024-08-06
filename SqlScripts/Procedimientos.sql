use EstudiantesDB;
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

CREATE PROCEDURE spInscribirEstudiante (
    @Usuario VARCHAR(50),
    @contraseña VARCHAR(50),
    @Periodo VARCHAR(50),
    @Pago VARCHAR(10)
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
            INSERT INTO T_Inscrito (Id_Estudiante, apellidos, nombres, Periodo, Pago)
            SELECT Id_Estudiante, apellidos, nombres, @Periodo, @Pago
            FROM T_Estudiante
            WHERE Id_Estudiante = @Usuario;
        END
    ELSE
      Print 'ERROR. '
    END
END;
go

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

CREATE PROCEDURE InsertarPagadosEnAsignados
    @TotalCupos INT,
    @Periodo VARCHAR(50)
AS
BEGIN
    DECLARE @Id_Estudiante VARCHAR(50);
    DECLARE @apellidos VARCHAR(50);
    DECLARE @nombres VARCHAR(50);
    DECLARE @Id_Reserva INT = 1;
    DECLARE @Contador INT = 0;

    -- DECLARE @Periodo VARCHAR(10);
    -- SELECT @Periodo=periodo FROM T_ThePeriod;


    DECLARE CursorInscritos CURSOR FOR
    SELECT Id_Estudiante, apellidos, nombres
    FROM T_Inscrito
    WHERE Pago = '1' AND Periodo = @Periodo;

    OPEN CursorInscritos;

    FETCH NEXT FROM CursorInscritos INTO @Id_Estudiante, @apellidos, @nombres;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insertar el registro en T_Asignados con el Id_Reserva actual
        INSERT INTO T_Asignados (Id_Estudiante, apellidos, nombres, Id_Reserva, Periodo)
        VALUES (@Id_Estudiante, @apellidos, @nombres, @Id_Reserva, @Periodo);

        -- Incrementar el contador
        SET @Contador = @Contador + 1;

        -- Si el contador alcanza el total de cupos, reiniciar el contador y aumentar Id_Reserva
        IF @Contador >= @TotalCupos
        BEGIN
            SET @Contador = 0;
            SET @Id_Reserva = @Id_Reserva + 1;
        END

        FETCH NEXT FROM CursorInscritos INTO @Id_Estudiante, @apellidos, @nombres;
    END;

    CLOSE CursorInscritos;
    DEALLOCATE CursorInscritos;
END;

