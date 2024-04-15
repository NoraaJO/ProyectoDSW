CREATE PROCEDURE definirCoordinador(
	@inIdEquipo INT,
	@inIdProfe INT, 
	@inIdAsisAdmin INT
)
AS
BEGIN
	SET NOCOUNT ON; 
	DECLARE @OutResult INT
	BEGIN TRY
		
		IF NOT EXISTS(SELECT 1 FROM dbo.EquiposTrabajo WHERE @inIdEquipo = id) AND  --Se comprueba exista tanto el equipo, profe y el profe.
		NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE id = @inIdProfe) AND
		NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE id = @inIdAsisAdmin)
		BEGIN 
			SET @OutResult = -1
			RETURN @OutResult 
		END
		ELSE
			IF NOT EXISTS(SELECT 1 FROM dbo.Usuario a INNER JOIN dbo.Sede S ON a.idSede = S.id
			WHERE @inIdAsisAdmin = A.id AND S.nombre = 'CA')
			BEGIN
				SET @OutResult = -2
				RETURN @OutResult 
			END
			
			IF EXISTS(SELECT 1 FROM dbo.ProfesoresGuia WHERE isCordinador = 1 AND idEquipo = @inIdEquipo)
			BEGIN
				SET @OutResult = -3
				RETURN @OutResult 
			END
			
			IF NOT EXISTS(SELECT 1 FROM dbo.ProfesoresGuia WHERE @inIdProfe = idProfesor AND @inIdEquipo = idEquipo)
			BEGIN
				SET @OutResult = -4
				RETURN @OutResult 
			END

			UPDATE dbo.ProfesoresGuia
			SET isCordinador = 1
			WHERE idProfesor = @inIdProfe AND idEquipo = @inIdEquipo

	END TRY 
	BEGIN CATCH
		SET @OutResult = -5
		RETURN @OutResult 
	END CATCH
	SET NOCOUNT OFF;
END