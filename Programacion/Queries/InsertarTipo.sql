TRUNCATE TABLE dbo.Tipo
DBCC CHECKIDENT ('Tipo', RESEED, 1);
INSERT INTO dbo.Tipo(nombre)
VALUES
		('Orientadoras'),
		('Motivacionales'),
		('De apoyo a la vida estudiantil'),
		('De orden t�cnico'),
		('De recreaci�n')
SELECT * FROM dbo.Tipo