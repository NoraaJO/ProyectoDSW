CREATE TABLE Actividades(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	semana INT NOT NULL,
	nombre VARCHAR(128),
	idTipo INT,
	fechaRealizacion DATE NOT NULL,
	modalidad INT NOT NULL,
	enlance VARCHAR(128),
	afiche VARCHAR(256),
	idEstado INT,
	idPlanTrabajo INT NOT NULL,
	cantidaRecor INT NOT NULL
);