TRUNCATE TABLE dbo.Sede
DBCC CHECKIDENT ('Sede', RESEED, 1);
INSERT INTO dbo.Sede (nombre)
VALUES
	('CA'),
	('SJ'),
	('LI'),
	('AL'),
	('SC')	
SELECT * FROM dbo.Sede