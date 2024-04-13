CREATE TABLE Comentario(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	idProfesor INT NOT NULL,
	idActividad INT NOT NULL,
	idComentario INT,
	Comentario VARCHAR(256) NOT NULL 
);
