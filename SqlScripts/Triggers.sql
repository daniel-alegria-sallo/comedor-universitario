CREATE TRIGGER ActualizarPago
ON T_Pagos
AFTER INSERT
AS
BEGIN
    DECLARE @IdEstudiante varchar(20)
    DECLARE @Period varchar(20)
    BEGIN TRY
        -- Assuming only one row is inserted at a time

        SELECT @IdEstudiante = Id_Estudiante,@Period=Periodo
        FROM inserted

        IF exists (SELECT  1 FROM T_Inscrito where Id_Estudiante=@IdEstudiante and Periodo=@Period)
        BEGIN
            UPDATE T_Inscrito
            SET Pago = '1'
            WHERE Id_Estudiante = @IdEstudiante
        end
        else
        begin
        rollback transaction
        end
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        ROLLBACK TRANSACTION

    END CATCH
END;
