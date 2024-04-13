CREATE PROCEDURE agregarAct(
	@inSemana INT,
	@inNombre VARCHAR(128),
	@inTipo VARCHAR(32),
	@inFechaRealizacion DATE,
	@inModalida INT,
	@inEnlance VARCHAR(128),
	@inAfiche VARCHAR(256),
	@inIdPlanTrb INT,
	@inCantRecord INT
)
AS
BEGIN
	 DECLARE @OutResult INT
	 BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM dbo.PlanTrabajo WHERE id = @inIdPlanTrb)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult 
		END
		ELSE 
		BEGIN
			INSERT INTO dbo.Actividades(semana, nombre, idTipo, fechaRealizacion, modalidad, enlance, afiche, idPlanTrabajo, cantidaRecor)
			VALUES( 
				@inSemana,
				@inNombre,
				(SELECT id FROM dbo.Tipo WHERE nombre = @inTipo),
				@inFechaRealizacion,
				@inModalida,
				@inEnlance,
				@inAfiche,
				@inIdPlanTrb,
				@inCantRecord
			)
		END
	 END TRY
	 BEGIN CATCH
			SET @OutResult = -2
			RETURN @OutResult 
	 END CATCH
END