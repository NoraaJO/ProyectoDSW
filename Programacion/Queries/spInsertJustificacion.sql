CREATE PROCEDURE InsertJustificacion(
	@inIdActividad INT,
	@inJustificacion VARCHAR(256)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @OutResult INT;
	BEGIN TRY 
		IF NOT EXISTS(SELECT 1 FROM dbo.Actividades A WHERE A.id = @inIdActividad) AND @inJustificacion IS NULL
		BEGIN
			SET @OutResult = -1;
			RETURN @OutResult;
		END
		ELSE
		BEGIN
			INSERT INTO dbo.Justificacion(idActividad, arcJustificacion)
			VALUES (@inIdActividad, @inJustificacion)
			SET @OutResult = 1;
			RETURN @OutResult;
		END 
	END TRY
	BEGIN CATCH
		SET @OutResult = -2;
		RETURN @OutResult; 
	END CATCH
	SET NOCOUNT OFF;
END