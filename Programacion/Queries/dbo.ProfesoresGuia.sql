CREATE TABLE ProfesoresGuia(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	idProfesor INT NOT NULL,
	idEquipo INT NOT NULL,
	isCordinador BIT NOT NULL
);