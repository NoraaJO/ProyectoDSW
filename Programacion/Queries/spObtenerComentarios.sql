CREATE PROCEDURE obtenerComentarios(
	@inIdActividad INT
)
AS
BEGIN
	DECLARE @OutResult INT
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM dbo.Actividades WHERE id = @inIdActividad)
		BEGIN
			SET @OutResult = 1
			RETURN @OutResult
		END
		ELSE 
		BEGIN
			SELECT 
				C.id,
				C.Comentario,
				C.Fecha,
				C.idComentario,
				U.Nombre+' '+U.Apellido1
			FROM dbo.Comentario C
			INNER JOIN dbo.Usuario U ON U.id = C.idProfesor
			WHERE C.idActividad = @inIdActividad
		END
	END TRY	
	BEGIN CATCH
		SET @OutResult = -1
		RETURN @OutResult
	END CATCH
END