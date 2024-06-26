
CREATE PROCEDURE [dbo].[spInsertarComentario](
	@inIdActividad INT,
	@inComentario INT,
	@InFecha DATE,
	@inIdProfesor INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	
	BEGIN TRY
		
		IF NOT EXISTS(SELECT 1 FROM dbo.Actividades A WHERE A.id = @inIdActividad)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult
		END
		ELSE 
		BEGIN
			INSERT INTO dbo.Comentario(idActividad, idComentario, idProfesor, Comentario, Fecha)
			VALUES (@inIdActividad, -1, @inIdProfesor, @inComentario, @InFecha)
			SET @OutResult = 1
			RETURN @OutResult
		END
	END TRY
	BEGIN CATCH
		SET @OutResult = -2
		RETURN @OutResult
	END CATCH
	SET NOCOUNT OFF;
END