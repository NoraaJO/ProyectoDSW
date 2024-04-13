CREATE PROCEDURE iniciarSesion(
	@inCorreo VARCHAR(64),
	@inPassword VARCHAR(32)
)
AS 
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT
	BEGIN TRY
		SET @OutResult = (SELECT id FROM dbo.Usuario U WHERE @inCorreo = U.correo AND U.password = @inPassword)
		IF @OutResult IS NULL
		BEGIN
			SET @OutResult = -1
		END
		RETURN @OutResult
	SET NOCOUNT OFF;
	END TRY

	BEGIN CATCH
		SET @OutResult = -2
		RETURN @OutResult
	END CATCH
	SET NOCOUNT OFF;
END