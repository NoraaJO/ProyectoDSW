CREATE PROCEDURE darDeBajaProfeEq(
	@inIdProfesor INT,
	@inIdEquipo INT,
	@inIdAsisAdminis INT
)
AS
BEGIN
	DECLARE @OutResult INT
	BEGIN TRY
		DECLARE @idSede INT
		DECLARE @Descripcion VARCHAR(64)
		IF NOT EXISTS(SELECT 1 FROM dbo.Profesor WHERE id = @inIdProfesor) AND 
		NOT EXISTS(SELECT 1 FROM dbo.EquiposTrabajo WHERE id = @inIdEquipo) AND
		NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE id = @inIdAsisAdminis)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult 
		END
		ELSE
		BEGIN
			SET @idSede = (SELECT idSede FROM dbo.Usuario WHERE  id = @inIdProfesor)
			IF  NOT (@idSede = (SELECT idSede FROM dbo.Usuario WHERe id = @inIdAsisAdminis))
			BEGIN
				SET @OutResult = -3
				RETURN @OutResult 
			END 

			DELETE FROM dbo.ProfesoresGuia
			WHERE idProfesor = @inIdProfesor AND idEquipo = @inIdEquipo 

			SET @Descripcion = 'Se elimino al profesor de id: '+CAST(@inIdProfesor AS VARCHAR(10))+' del equipo de id: '+CAST(@inIdEquipo AS VARCHAR(10))  
			INSERT INTO dbo.Logs(Detalles, idUsuario)
			VALUES (@Descripcion, @inIdAsisAdminis)

		END
	END TRY
	BEGIN CATCH
		SET @OutResult = -4
		RETURN @OutResult 
	END CATCH
END