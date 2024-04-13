CREATE PROCEDURE ActualizarEstado(
	@inIdActividad INT,
	@inEstado VARCHAR(32)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM dbo.Actividades A WHERE A.id=@inIdActividad)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult
		END
		ELSE
		BEGIN
			UPDATE dbo.Actividades 
			SET idEstado = (SELECT id FROM dbo.Estado WHERE nombre = @inEstado)
			WHERE id = @inIdActividad
			SET @OutResult = 1
			RETURN @OutResult
		END
	END TRY
	BEGIN CATCH
		SET @OutResult = -1
		RETURN @OutResult
	END CATCH
	SET NOCOUNT OFF;
END