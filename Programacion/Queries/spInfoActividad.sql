CREATE PROCEDURE obtenerDatosActividad(
	@inIdActividad INT
)
AS
BEGIN
	DECLARE @OutResult INT
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM dbo.Actividades)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult 
		END
		ELSE 
		BEGIN
			SELECT 
				A.nombre,
				A.semana,
				CASE
					WHEN A.modalidad = 0 THEN 'Remota'
					WHEN A.modalidad = 1 THEN 'Virtual'
				END,
				T.nombre,
				E.nombre,
				A.fechaRealizacion,
				A.enlance,
				A.cantidaRecor,
				A.afiche
			FROM dbo.Actividades A
			INNER JOIN dbo.Tipo T ON T.id = A.idTipo
			INNER JOIN dbo.Estado E ON E.id = A.idEstado
			WHERE A.id = @inIdActividad 
		END
	END TRY
	BEGIN CATCH
		SET @OutResult = -2
		RETURN @OutResult 
	END CATCH
END