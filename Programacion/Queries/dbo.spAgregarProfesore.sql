USE [GETG]
GO

/****** Object:  StoredProcedure [dbo].[AgregarProfesor]    Script Date: 4/9/2024 12:58:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AgregarProfesor](
	@InCorreo VARCHAR(64),
	@InPassword VARCHAR(32),
	@InSede VARCHAR(32),
	@InNombre VARCHAR(32),
	@InApellido1 VARCHAR(32),
	@InApellido2 VARCHAR(32),
	@InCelular INT,
	@InNumOficina INT,
	@InExtension INT,
	@InImagen VARCHAR(128)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @OutResult INT; 
	BEGIN TRY
			DECLARE @Count INT;
			DECLARE @Codigo VARCHAR(32);
			IF EXISTS(SELECT 1 FROM dbo.Usuario U WHERE U.correo = @InCorreo)
			BEGIN
				SET @OutResult = 11
				PRINT('Ya existe un usuario con dicho correo')
				RETURN @OutResult
			END
			SET @Count =(SELECT COUNT(*) FROM dbo.Usuario U INNER JOIN dbo.Sede S ON S.id = U.idSede 
						WHERE @InSede = S.nombre);
			SET @Codigo = @InSede+'-'+CAST(@Count AS VARCHAR(10));
		
			INSERT INTO dbo.Usuario(correo, idSede, idTipo, password)
			VALUES(@InCorreo, (SELECT id FROM dbo.Sede WHERE nombre = @InSede), 1, @InPassword)

			SET @Count = SCOPE_IDENTITY()
			INSERT INTO dbo.Profesor(id, Nombre, Apellido1, Apellido2, celular, numOficina, extension, imagen, 
									Codigo)
			VALUES(@Count, @InNombre, @InApellido1, @InApellido2, @InCelular, @InNumOficina, 
					@InExtension, @InImagen, @Codigo)
			SET @OutResult = 1
			RETURN @OutResult
	END TRY
	BEGIN CATCH
		SET @OutResult = -1
		RETURN @OutResult
	END CATCH
	
	SET NOCOUNT OFF;
END
GO


