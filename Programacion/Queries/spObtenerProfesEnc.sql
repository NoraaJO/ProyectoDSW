CREATE PROCEDURE obtenerProfesEnc(
	@inIdActividad INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY 
		IF NOT EXISTS(SELECT 1 FROM dbo.Actividades WHERE id = @inIdActividad)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult 
		END
		SELECT 
			U.nombre,
			U.Apellido1
		FROM dbo.ProferesEncargado E
		INNER JOIN dbo.Usuario U ON E.idProfesor = U.id
		WHERE E.idActividad = @inIdActividad
	END TRY
	BEGIN CATCH
		SET @OutResult = -2
		RETURN @OutResult 
	END CATCH
	SET NOCOUNT OFF;
END