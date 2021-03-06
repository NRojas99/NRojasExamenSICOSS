USE [master]
GO
/****** Object:  Database [ExamenSICOSS]    Script Date: 31/05/2022 01:57:18 p. m. ******/
CREATE DATABASE [ExamenSICOSS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ExamenSICOSS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ExamenSICOSS.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ExamenSICOSS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ExamenSICOSS_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ExamenSICOSS] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ExamenSICOSS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ExamenSICOSS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET ARITHABORT OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ExamenSICOSS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ExamenSICOSS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ExamenSICOSS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ExamenSICOSS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ExamenSICOSS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET RECOVERY FULL 
GO
ALTER DATABASE [ExamenSICOSS] SET  MULTI_USER 
GO
ALTER DATABASE [ExamenSICOSS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ExamenSICOSS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ExamenSICOSS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ExamenSICOSS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ExamenSICOSS', N'ON'
GO
USE [ExamenSICOSS]
GO
/****** Object:  StoredProcedure [dbo].[AddHistorial]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddHistorial]
@IdUsuario INT
,@IdSuperDigito INT
AS
INSERT INTO [Historial]
           ([IdUsuario]
           ,[IdSuperDigito])
     VALUES
           (@IdUsuario
           ,@IdSuperDigito)

GO
/****** Object:  StoredProcedure [dbo].[AddSuperDigito]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddSuperDigito]
@IdSuperDigito INT OUTPUT
,@Numero INT
,@Resultado INT
AS
INSERT INTO [SuperDigito]
           ([Numero]
           ,[Resultado]
		   ,Fecha)
     VALUES
           (@Numero
		   ,@Resultado
		   ,GETDATE())
		   SET @IdSuperDigito=@@IDENTITY

GO
/****** Object:  StoredProcedure [dbo].[AddUsuario]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[AddUsuario]
 @UserName VARCHAR(50)
 ,@Password VARCHAR(50)
 AS
 INSERT INTO [dbo].[Usuario]
           ([UserName]
           ,[Password])
     VALUES
           (@UserName
           ,@Password)

GO
/****** Object:  StoredProcedure [dbo].[DeleteHistorialIdUsuario]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteHistorialIdUsuario]
@IdUsuario INT
AS
DELETE FROM [Historial]
      WHERE IdUsuario= @IdUsuario
GO
/****** Object:  StoredProcedure [dbo].[GetUsername]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[GetUsername]
  @Username VARCHAR(50)
  AS
  SELECT [IdUsuario]
      ,[UserName]
      ,[Password]
  FROM [Usuario]
  WHERE @Username = UserName
GO
/****** Object:  StoredProcedure [dbo].[IdSuperDigitoGetResultado]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IdSuperDigitoGetResultado] 
@IdSuperDigito INT
AS
SELECT[IdHistorial]
      ,SuperDigito.IdSuperDigito
	  ,SuperDigito.Numero
	  ,SuperDigito.Resultado
  FROM [Historial]
  INNER JOIN SuperDigito ON SuperDigito.IdSuperDigito= Historial.IdSuperDigito
  WHERE SuperDigito.IdSuperDigito = @IdSuperDigito
GO
/****** Object:  StoredProcedure [dbo].[IdUsuarioGetHistorial]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IdUsuarioGetHistorial] 
@IdUsuario INT
AS
SELECT Historial.[IdHistorial]
      ,Usuario.[IdUsuario]
      ,SuperDigito.[IdSuperDigito]
	  ,SuperDigito.Numero 
	  ,SuperDigito.Resultado
	  ,SuperDigito.Fecha
  FROM [Historial]
  INNER JOIN Usuario ON Usuario.IdUsuario = Historial.IdUsuario
  INNER JOIN SuperDigito ON SuperDigito.IdSuperDigito= Historial.IdSuperDigito
  WHERE Historial.IdUsuario = @IdUsuario
GO
/****** Object:  StoredProcedure [dbo].[IdUsuarioGetNumero]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IdUsuarioGetNumero]
@IdUsuario INT
AS
SELECT[IdHistorial]
      ,Usuario.[IdUsuario]
	  ,SuperDigito.IdSuperDigito
	  ,SuperDigito.Numero 
  FROM [Historial]
  INNER JOIN Usuario ON Usuario.IdUsuario = Historial.IdUsuario
  INNER JOIN SuperDigito ON SuperDigito.IdSuperDigito= Historial.IdSuperDigito
  WHERE Usuario.IdUsuario= @IdUsuario
GO
/****** Object:  StoredProcedure [dbo].[UpdateFecha]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFecha] 
@Numero INT
,@IdSuperdigito INT
AS
UPDATE [SuperDigito]
   SET 
      SuperDigito.Fecha = GETDATE()
 WHERE Numero =@Numero AND IdSuperDigito=@IdSuperDigito
GO
/****** Object:  Table [dbo].[Historial]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historial](
	[IdHistorial] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[IdSuperDigito] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdHistorial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SuperDigito]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuperDigito](
	[IdSuperDigito] [int] IDENTITY(1,1) NOT NULL,
	[Numero] [int] NULL,
	[Resultado] [int] NULL,
	[Fecha] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdSuperDigito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 31/05/2022 01:57:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Historial] ON 

INSERT [dbo].[Historial] ([IdHistorial], [IdUsuario], [IdSuperDigito]) VALUES (22, 1, 23)
SET IDENTITY_INSERT [dbo].[Historial] OFF
SET IDENTITY_INSERT [dbo].[SuperDigito] ON 

INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (1, 129, 3, CAST(0x0000AEA600C6EAFB AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (2, 13, 4, CAST(0x0000AEA600E2BB23 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (3, 5, 5, CAST(0x0000AEA50117D6C6 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (4, 3, 3, CAST(0x0000AEA501257298 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (5, 5, 5, CAST(0x0000AEA50133357F AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (6, 14, 5, CAST(0x0000AEA50134CEF4 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (7, 14, 5, CAST(0x0000AEA501358A93 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (8, 1, 1, CAST(0x0000AEA501360943 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (9, 14, 5, CAST(0x0000AEA50137394A AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (10, 6, 6, CAST(0x0000AEA501768983 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (11, 1, 1, CAST(0x0000AEA50179F707 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (12, 5, 5, CAST(0x0000AEA600DDA685 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (13, 23, 5, CAST(0x0000AEA50187AA2A AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (14, 18, 9, CAST(0x0000AEA6001D461F AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (15, 85, 4, CAST(0x0000AEA600A79443 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (16, 124, 7, CAST(0x0000AEA600A7DF00 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (17, 19, 1, CAST(0x0000AEA600AD086E AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (18, 85, 4, CAST(0x0000AEA600AD6D75 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (19, 129, 3, CAST(0x0000AEA600C317C7 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (20, 5, 5, CAST(0x0000AEA600AD831B AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (21, 1, 1, CAST(0x0000AEA600CB460C AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (22, 10, 1, CAST(0x0000AEA600D43DF2 AS DateTime))
INSERT [dbo].[SuperDigito] ([IdSuperDigito], [Numero], [Resultado], [Fecha]) VALUES (23, 129, 3, CAST(0x0000AEA600E38A02 AS DateTime))
SET IDENTITY_INSERT [dbo].[SuperDigito] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (1, N'Nayeli', N'123NR')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (2, N'Miguel', N'123MB')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (3, N'Axel', N'123AT')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (4, N'Saul', N'123SQ')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (5, N'Daniel', N'123DT')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (6, N'Nancy', N'123Nan')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (7, N'Sam28GB', N'sam')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (8, N'isaacjeo', N'12345')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (9, N'Aldahir', N'123AS')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (10, N'Axel', N'123AT')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (11, N'Miguel S', N'123MS')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (12, N'123', N'12')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (13, N'Melisa', N'123M')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (14, N'Hernan', N'123H')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (15, N'Daf23', N'123')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (16, N'Sam28GB', N'123')
INSERT [dbo].[Usuario] ([IdUsuario], [UserName], [Password]) VALUES (17, N'asdsd12', N'ABC')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
ALTER TABLE [dbo].[Historial]  WITH CHECK ADD FOREIGN KEY([IdSuperDigito])
REFERENCES [dbo].[SuperDigito] ([IdSuperDigito])
GO
ALTER TABLE [dbo].[Historial]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
USE [master]
GO
ALTER DATABASE [ExamenSICOSS] SET  READ_WRITE 
GO
