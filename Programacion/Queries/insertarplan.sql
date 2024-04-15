CREATE PROCEDURE insertarPlan(
	@inIdEquipo INT,
	@inPeriodo INT 
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM dbo.EquiposTrabajo WHERE id = @inIdEquipo)
		BEGIN
			SET @OutResult =-1
		END
		ELSE 
		BEGIN
			INSERT INTO dbo.PlanTrabajo(idEquipoTrabajo, periodo)
			VALUES(@inIdEquipo, @inPeriodo)
			SET @OutResult = 1
		END
		RETURN @OutResult

	END TRY

	BEGIN CATCH
		SET @OutResult = -2
		RETURN @OutResult
	END CATCH
	SET NOCOUNT OFF;
END