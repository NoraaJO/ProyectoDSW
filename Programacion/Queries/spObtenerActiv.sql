CREATE PROCEDURE spObtenerActivi(
	@inIdPlanTrab INT
)
AS 
BEGIN
	DECLARE @OutResult INT
	BEGIN TRY 
		IF NOT EXISTS(SELECT 1 FROM dbo.PlanTrabajo WHERE id = @inIdPlanTrab)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult 			
		END
		ELSE
		BEGIN
			SELECT 
				A.nombre,
				E.nombre
			FROM dbo.Actividades A
			INNER JOIN dbo.Estado E ON E.id = A.idTipo
			WHERE A.idPlanTrabajo = @inIdPlanTrab
			ORDER BY A.id ASC			
		END
	END TRY
	BEGIN CATCH
		SET @OutResult = -2
		RETURN @OutResult 
	END CATCH
END