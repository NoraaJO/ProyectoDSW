CREATE PROCEDURE CambiarPassword(
	@inCorreo VARCHAR(64),
	@inNewPassword VARCHAR(32)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY
		IF NOT EXISTS(SELECT 1 FROM dbo.Usuario WHERE correo = @inCorreo)
		BEGIN
			SET @OutResult = -1;
		END
		ELSE
		BEGIN
			IF LEN(@inNewPassword) != 8
			BEGIN
				SET @OutResult = -2;
			END
			ELSE
				BEGIN
					UPDATE dbo.Usuario
					SET password = @inNewPassword
					WHERE correo = @inCorreo
					SET @OutResult = 1;
				END
		END
		
		RETURN @OutResult
	END TRY

	BEGIN CATCH
	
		SET @OutResult = -3;
		RETURN @OutResult
	
	END CATCH
	SET NOCOUNT OFF;
END