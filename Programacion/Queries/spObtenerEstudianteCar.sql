CREATE PROCEDURE obtenerDatosEstudianteCarnet(
	@inIdUsuario INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY
		DECLARE @idSede INT
		IF NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE id = @inIdUsuario)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult
		END
		SET @idSede = (SELECT idSede FROM dbo.Usuario WHERE @inIdUsuario = id)
		
		SELECT 
			U.Nombre,
			U.Apellido1,
			U.Apellido2,
			E.carnet
		FROM dbo.Usuario U
		INNER JOIN dbo.Estudiante E ON E.id = U.id
		WHERE U.idSede = @idSede AND idTipo = 3
		ORDER BY E.carnet ASC

	END TRY 
	BEGIN CATCH
		RETURN -1
	END CATCH
	SET NOCOUNT OFF;
END