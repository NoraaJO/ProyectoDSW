CREATE PROCEDURE spModificarDatoProfesor(
	@inIdProfesor INT, 
	@inNombre VARCHAR(32),
	@inCorreo VARCHAR(64),
	@inApellido1 VARCHAR(32),
	@inApellido2 VARCHAR(32),
	@inCelular INT,
	@inNumOficina INT,
	@inExtension INT,
	@inImagen VARCHAR(128),
	@inIdUsEnc INT
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY

		DECLARE @sedeProf INT
		DECLARE @Descripcion VARCHAR(64)

		IF NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE @inIdProfesor = id) AND --Se comprueba que existan tanto el profesor como el que realiza el cambio
		NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE @inidUsEnc = id)
		BEGIN
			SET @OutResult = -1
			RETURN @OutResult 
		END
		ELSE 
		BEGIN
			IF NOT (@inidUsEnc = @inIdProfesor)
			BEGIN
				SET @sedeProf = (SELECT I.idSede FROM dbo.Usuario I WHERE @inIdProfesor = I.id) 

				IF NOT (@sedeProf = (SELECT idSede FROM dbo.Usuario WHERE @inidUsEnc = id)) --Si no son pertenencientes a la misma sede
				BEGIN
					SET @OutResult = -2
					RETURN @OutResult 
				END
			END
			
			IF EXISTS(SELECT 1 FROM dbo.Usuario WHERE @inCorreo = correo and id <> @inIdProfesor) --Exista correo
				BEGIN
					SET @OutResult = -3
					RETURN @OutResult 
				END 

				UPDATE dbo.Usuario
				SET Nombre = @innombre,
					correo = @inCorreo,
					Apellido1= @inApellido1,
					Apellido2 = @inApellido2,
					celular = @inCelular
				WHERE @inIdProfesor = id
				
				UPDATE dbo.Profesor
				SET numOficina = @inNumOficina, 
					extension = @inExtension,
					imagen = @inImagen
				WHERE id = @inIdProfesor
				
				SET @Descripcion = 'Se realizaron cambios a la información del usuario de nombre'+(SELECT nombre FROM dbo.Usuario WHERE id = @inIdProfesor)+' de id '+@inIdProfesor
				INSERT INTO dbo.Logs(idUsuario, Detalles)
				VALUES (@inIdUsEnc, @Descripcion)

				SET @OutResult = 1
				RETURN @OutResult
		END

	END TRY
	BEGIN CATCH
		
		SET @OutResult = -4
		RETURN @OutResult
		
	END CATCH
	SET NOCOUNT OFF;
END