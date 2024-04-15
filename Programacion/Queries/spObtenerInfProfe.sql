CREATE PROCEDURE obtenerDatosProfeso(
	@inIdProfesor INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE @inIdProfesor = id)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult 
		END
		ELSE
		BEGIN
			SELECT 
				U.Nombre,
				U.Apellido1,
				U.Apellido2,
				U.celular,
				U.correo,
				S.nombre,
				P.Codigo,
				P.extension,
				P.numOficina,
				P.imagen
			FROM dbo.Usuario U
			INNER JOIN dbo.Profesor P ON P.id = U.Nombre
			INNER JOIN dbo.Sede S ON S.id =U.idSede
			WHERE U.id = @inIdProfesor
		END
	END TRY
	BEGIN CATCH
		SET @OutResult = -2
		RETURN @OutResult 
	END CATCH
	SET NOCOUNT OFF;
END 