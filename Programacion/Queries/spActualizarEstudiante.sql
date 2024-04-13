CREATE PROCEDURE ActualizarEstudiante(
	@inIdUsEnc INT,
	@inIdEstudian INT,
	@inNombre VARCHAR(32),
	@inApellido1 VARCHAR(32),
	@inApellido2 VARCHAR(32),
	@inCelular VARCHAR(32),
	@inCorreo VARCHAR(64)
)
AS
BEGIN
	DECLARE @OutResult INT;
	BEGIN TRY
		DECLARE @sede INT;
		DECLARE @Descripcion VARCHAR(64);
		IF NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE id = @inIdUsEnc) AND 
		NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE id =@inIdUsEnc) --Se comprueba que los id del estudiante como el que realiza el cambio exista.
		BEGIN
			SET @OutResult = -1;
			RETURN @OutResult ;
		END
		ELSE
		BEGIN	
			SET @sede = (SELECT idSede FROM dbo.Usuario WHERE @inIdEstudian = id)
			IF NOT (@sede = (SELECT idSede FROM dbo.Usuario WHERE @inIdUsEnc = id) ) -- Comprobación de que ambos 
			BEGIN
				SET @OutResult = -2;
				RETURN @OutResult;
			END
			
			IF NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE @inCorreo = correo AND @inIdEstudian <> id)
			BEGIN
				SET @OutResult = -3;
				RETURN @OutResult;
			END

			UPDATE dbo.Usuario
			SET Nombre= @inNombre,
				Apellido1 = @inApellido1,
				Apellido2 = @inApellido2,
				correo = @inCorreo,
				celular = @inCelular
			WHERE id = @inIdEstudian

			SET @Descripcion = 'Se realizaron cambios a la información del usuario de nombre'+(SELECT nombre FROM dbo.Usuario WHERE id = @inIdEstudian)+' de id '+@inIdEstudian
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
END