
CREATE TABLE [dbo].[Usuario] (
    [id]		INT          IDENTITY (1, 1) NOT NULL,
    [password]	VARCHAR (32) NULL,
    [correo]	VARCHAR (64) NULL,
    [idSede]	INT          NULL,
    [idTipo]	INT          NULL,
	[Nombre]     VARCHAR (32)  NULL,
    [Apellido1]  VARCHAR (32)  NULL,
    [Apellido2]  VARCHAR (32)  NULL,
    [celular]    INT           NULL,
);


