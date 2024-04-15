ALTER PROCEDURE obtenerDatosEquipo(
	@inIdEquipo INT
)
AS
BEGIN
	BEGIN TRY
		SELECT
			P.id,
			P.Codigo,
			U.Nombre,
			U.Apellido1,
			U.Apellido2,
			G.isCordinador
		FROM dbo.ProfesoresGuia G
		INNER JOIN dbo.Usuario U ON U.id = G.idProfesor
		INNER JOIN dbo.Profesor P ON P.id = U.id
		WHERE G.idEquipo = @inIdEquipo
	END TRY
	BEGIN CATCH
		RETURN -1
	END CATCH
END