CREATE PROCEDURE AgregarProfesorEquipo(
	@inIdEquipo INT,
	@inidProfesor INT, 
	@inidUsuario INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DEClARE @OutResult INT

	BEGIN TRY
		 DECLARE @idSede INT	 
		 IF NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE id=@inidProfesor) AND 
		 NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE id = @inidUsuario)	AND
		 NOT EXISTS(SELECT 1 FROM dbo.EquiposTrabajo WHERE id = @inIdEquipo)
		 BEGIN
			SET @OutResult = -1
			RETURN @OutResult 
		 END
		 ELSE
		 BEGIN
			 SET @idSede = (SELECT U.idSede FROM dbo.Usuario U WHERE U.id = @inidProfesor)
			 IF EXISTS(
				SELECT 
				1
				FROM dbo.ProfesoresGuia E
				INNER JOIN dbo.Usuario U ON U.id = E.idProfesor
				WHERE @idSede = u.idSede
			 )
			 BEGIN
				SET @OutResult = -2
			 END
			 IF @idSede = (SElECT U.idSede FROM dbo.Usuario U WHERE U.id = @inidUsuario)
			 BEGIN

				INSERT INTO dbo.ProfesoresGuia(idEquipo, idProfesor, isCordinador)
				VALUES (@inIdEquipo, @inidProfesor, 0)
				SET @OutResult = 1
				RETURN @OutResult
			 
			 END
			 ELSE
			 BEGIN
				
				SET @OutResult = -4
				RETURN @OutResult
			 
			 END
		END

	END TRY
	BEGIN CATCH
		
		SET @OutResult = -5
		RETURN @OutResult
	
	END CATCH
	
	SET NOCOUNT OFF;
END 