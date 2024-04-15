CREATE PROCEDURE obtenerProxActividad(
	@inFechaAct DATE,
	@inIdPlanActividad INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM dbo.PlanTrabajo WHERE @inIdPlanActividad = id)
		BEGIN 
			SET @OutResult = -2
			RETURN @OutResult
		END
		SELECT TOP(1)
			A.id,
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
		WHERE (DATEDIFF(DAY, @inFechaAct, fechaRealizacion)) = ABS(DATEDIFF(DAY, @inFechaAct, fechaRealizacion))
		AND A.idPlanTrabajo = @inIdPlanActividad
		ORDER BY (DATEDIFF(DAY, @inFechaAct, fechaRealizacion)) ASC
	END TRY
	BEGIN CATCH
		SET @OutResult = -2
		RETURN @OutResult
	END CATCH
	SET NOCOUNT OFF;
END