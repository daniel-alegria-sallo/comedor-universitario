USE [master]
GO

/****** Object:  Database [EstudiantesDB]    Script Date: 16/07/2024 8:29:45 ******/
CREATE DATABASE [EstudiantesDB]
	CONTAINMENT = NONE
	ON  PRIMARY
	( NAME = N'EstudiantesDB', FILENAME = N'/var/opt/mssql/data/EstudiantesDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
	LOG ON
	( NAME = N'BD_Estudiantes_Log', FILENAME = N'/var/opt/mssql/data/EstudiantesDB.ldf' , SIZE = 5120KB , MAXSIZE = 2048GB , FILEGROWTH = 1024KB )
	WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

ALTER DATABASE [EstudiantesDB] SET COMPATIBILITY_LEVEL = 150
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
	EXEC [EstudiantesDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [EstudiantesDB] SET ANSI_NULL_DEFAULT OFF
ALTER DATABASE [EstudiantesDB] SET ANSI_NULLS OFF
ALTER DATABASE [EstudiantesDB] SET ANSI_PADDING OFF
ALTER DATABASE [EstudiantesDB] SET ANSI_WARNINGS OFF
ALTER DATABASE [EstudiantesDB] SET ARITHABORT OFF
ALTER DATABASE [EstudiantesDB] SET AUTO_CLOSE OFF
ALTER DATABASE [EstudiantesDB] SET AUTO_SHRINK OFF
ALTER DATABASE [EstudiantesDB] SET AUTO_UPDATE_STATISTICS ON
ALTER DATABASE [EstudiantesDB] SET CURSOR_CLOSE_ON_COMMIT OFF
ALTER DATABASE [EstudiantesDB] SET CURSOR_DEFAULT  GLOBAL
ALTER DATABASE [EstudiantesDB] SET CONCAT_NULL_YIELDS_NULL OFF
ALTER DATABASE [EstudiantesDB] SET NUMERIC_ROUNDABORT OFF
ALTER DATABASE [EstudiantesDB] SET QUOTED_IDENTIFIER OFF
ALTER DATABASE [EstudiantesDB] SET RECURSIVE_TRIGGERS OFF
ALTER DATABASE [EstudiantesDB] SET  ENABLE_BROKER
ALTER DATABASE [EstudiantesDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
ALTER DATABASE [EstudiantesDB] SET DATE_CORRELATION_OPTIMIZATION OFF
ALTER DATABASE [EstudiantesDB] SET TRUSTWORTHY OFF
ALTER DATABASE [EstudiantesDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
ALTER DATABASE [EstudiantesDB] SET PARAMETERIZATION SIMPLE
ALTER DATABASE [EstudiantesDB] SET READ_COMMITTED_SNAPSHOT OFF
ALTER DATABASE [EstudiantesDB] SET HONOR_BROKER_PRIORITY OFF
ALTER DATABASE [EstudiantesDB] SET RECOVERY FULL
ALTER DATABASE [EstudiantesDB] SET  MULTI_USER
ALTER DATABASE [EstudiantesDB] SET PAGE_VERIFY CHECKSUM
ALTER DATABASE [EstudiantesDB] SET DB_CHAINING OFF
ALTER DATABASE [EstudiantesDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
ALTER DATABASE [EstudiantesDB] SET TARGET_RECOVERY_TIME = 60 SECONDS
ALTER DATABASE [EstudiantesDB] SET DELAYED_DURABILITY = DISABLED
ALTER DATABASE [EstudiantesDB] SET ACCELERATED_DATABASE_RECOVERY = OFF
EXEC sys.sp_db_vardecimal_storage_format N'EstudiantesDB', N'ON'
ALTER DATABASE [EstudiantesDB] SET QUERY_STORE = OFF

USE [EstudiantesDB]
GO
/****** Object:  Table [dbo].[T_Estudiante]    Script Date: 16/07/2024 8:29:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Estudiante](
	[Id_Estudiante] [varchar](10) NOT NULL,
	[apellidos] [varchar](50) NOT NULL,
	[nombres] [varchar](50) NOT NULL,
	[semestre] [int] NULL,
	PRIMARY KEY CLUSTERED ( [Id_Estudiante] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
	ON [PRIMARY]) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[T_Usuario]    Script Date: 16/07/2024 8:29:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Usuario](
	[Id_Estudiante] [varchar](10) NOT NULL,
	[Contraseña] [varchar](50) NOT NULL,
	PRIMARY KEY CLUSTERED ( [Id_Estudiante] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY])
	ON [PRIMARY]
GO

/****** Object:  UserDefinedFunction [dbo].[fnValidarUsuarioYRecuperarDatos]    Script Date: 16/07/2024 8:29:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION [dbo].[fnValidarUsuarioYRecuperarDatos] (
    @Usuario VARCHAR(50),
    @Contraseña VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT e.Id_Estudiante, e.Apellidos, e.Nombres
    FROM T_Usuario r
    INNER JOIN T_estudiante e ON r.Id_Estudiante = e.Id_Estudiante
    WHERE r.Id_Estudiante= @Usuario AND r.Contraseña = @Contraseña
);
GO

/****** Object:  Table [dbo].[T_Administradores]    Script Date: 16/07/2024 8:29:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Administradores](
	[Id_Administrador] [varchar](10) NOT NULL,
	[Contraseña] [varchar](50) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellidos] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED
(
	[Id_Administrador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[T_Asistencia]    Script Date: 16/07/2024 8:29:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Asistencia](
	[Id_Atencion] [varchar](50) NOT NULL,
	[Id_Estudiante] [varchar](50) NOT NULL,
	[Fecha] [date] NOT NULL,
 CONSTRAINT [PK_T_Asistencia] PRIMARY KEY CLUSTERED
(
	[Id_Atencion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[T_Curso]    Script Date: 16/07/2024 8:29:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Curso](
	[idCurso] [varchar](20) NOT NULL,
	[nombreCurso] [varchar](50) NOT NULL,
	[creditos] [int] NULL,
	[semestre] [int] NULL,
PRIMARY KEY CLUSTERED
(
	[idCurso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[T_Inscrito]    Script Date: 16/07/2024 8:29:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Inscrito](
	[Id_inscrito] [int] IDENTITY(1,1) NOT NULL,
	[Id_Estudiante] [varchar](10) NOT NULL,
	[apellidos] [varchar](50) NOT NULL,
	[nombres] [varchar](50) NOT NULL,
	[periodo] [varchar](50) NULL,
	[pago] [varchar](2) NULL,
PRIMARY KEY CLUSTERED
(
	[Id_inscrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF063AIN', N'QUECHUA', 2, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF454AIN', N'TEORIA DE LA COMPUTACION', 3, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF454BIN', N'TEORIA DE LA COMPUTACION', 3, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF455AIN', N'ALGORITMOS PARALELOS Y DISTRIBUIDOS', 4, 6)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF456AIN', N'ALGORITMOS AVANZADOS', 4, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF457AIN', N'METODOS NUMERICOS', 3, 6)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF458AIN', N'COMPUTACION GRAFICA', 4, 6)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF458BIN', N'COMPUTACION GRAFICA', 4, 6)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF466AIN', N'COMPILADORES', 3, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF467AIN', N'ANALISIS Y DISEÑO DE ALGORITMOS', 3, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF467BIN', N'ANALISIS Y DISEÑO DE ALGORITMOS', 3, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF481AIN', N'INGENIERIA ECONOMICA', 3, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF481BIN', N'INGENIERIA ECONOMICA', 3, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF550AIN', N'ORGANIZACION Y ARQUITECTURA DEL COMPUTADOR', 4, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF550BIN', N'ORGANIZACION Y ARQUITECTURA DEL COMPUTADOR', 4, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF551BIN', N'SISTEMAS OPERATIVOS', 4, 6)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF552AIN', N'REDES DE COMPUTADORAS I', 4, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF552BIN', N'REDES DE COMPUTADORAS I', 4, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF610BIN', N'ANALISIS Y DISEÑO DE SISTEMAS DE INFORMACION', 4, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF611AIN', N'METODOLOGIA DE DESARROLLO DE SOFTWARE', 3, 6)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF612AIN', N'FUNDAMENTOS Y DISEÑO DE BASE DE DATOS', 4, 6)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF613AIN', N'DESARROLLO DE SOFTWARE I', 2, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF613BIN', N'DESARROLLO DE SOFTWARE I', 2, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF613CIN', N'DESARROLLO DE SOFTWARE I', 2, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF650AIN', N'MODELOS PROBABILISTICOS', 4, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF650BIN', N'MODELOS PROBABILISTICOS', 4, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF651AIN', N'INTELIGENCIA ARTIFICIAL', 4, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'IF651BIN', N'INTELIGENCIA ARTIFICIAL', 4, 7)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'ME356AIN', N'ECUACIONES DIFERENCIALES', 4, 5)
INSERT [dbo].[T_Curso] ([idCurso], [nombreCurso], [creditos], [semestre]) VALUES (N'ME356BIN', N'ECUACIONES DIFERENCIALES', 4, 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'021501', N'CONDORI-CONTRERAS', N'ALAIN ARMANDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'083221', N'TRUJILLO-TORBISCO', N'LUIS ANDERSON', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'090215', N'GIBAJA-HUAYHUA', N'JUAN CARLOS', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'093178', N'MAMANI-CRISPIN', N'ISAI ISAAC', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'101658', N'CHOQUE-CCOA', N'DENNIS ALIPIO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'101659', N'FERIA-TAPARA', N'JOSE ADOLFO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'101664', N'QUISPE-RODRIGUEZ', N'LUIS ALEXEI', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'103647', N'QUISPE-ARONI', N'JESUS ADEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'110071', N'MUNIVE-SALAS', N'CIRO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'111864', N'HUILLCA-QUISPE', N'YULIZA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'113547', N'QUINAYA-MEJIA', N'RONY WILSON', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'113562', N'MENDOZA-HUAILLAPUMA', N'ELISBAN', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'114136', N'ALMIRON-GONZALES', N'JUAN RAISER', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'120893', N'PORROA-SIVANA', N'YENI RUTH', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'120895', N'QUISPE-PICHUILLA', N'AYRTON', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'133962', N'CHOQUENAIRA-QUISPE', N'NOE FRANKLIN', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'134403', N'CALLAPIÑA-CASTILLA', N'CIRO GABRIEL', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'140997', N'TRIVEÑOS-CALLER', N'DERICK ADOLPHO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'141000', N'ASCUE-PEÑA', N'AXEL RICARDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'141010', N'RAMIREZ-ALVAREZ', N'LUISBERTO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'141599', N'VENTURA-JAUJA', N'JAIME', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'141664', N'CONDE-PADIN', N'GEORGE ADOLFO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'141671', N'PAREDES-DENOS', N'VICTOR ANIVAL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'141677', N'NINAHUANCA-CHOQUE', N'JUAN CARLOS', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'143833', N'MELO-GUTIERREZ', N'RAUL ELVER', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'150400', N'OCHOA-MAMANI', N'RICARDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'150401', N'PARI-ARRIAGA', N'DENILSON', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'154628', N'CONDORI-HUAYCHAY', N'CESAR APARICIO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'154635', N'CONDORI-HUILLCA', N'JOSE ANTONIO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'160327', N'CUSI-HUAMAN', N'KEVIN YEISON', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'160696', N'HUAMAN-MORALES', N'ANGGIE ANTUANE', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'161136', N'TTITO-OCSA', N'JOSE ROLANDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'161534', N'ZEGARRA-ROJAS', N'JORGE ENRIQUE', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'163807', N'CHATA-HUALLPAYUNCA', N'MILTON ANDERSON', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'164244', N'MOLOCHO-CONDORI', N'BRAYAN VLADYMIR', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'164246', N'PACHA-QUISPE', N'JEAN MARCO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'164563', N'CARPIO-HERMOZA', N'HAIDER ALEX', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'170431', N'CRUZ-CARRION', N'JOSE LUIS', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'170433', N'HOLGUIN-CONDORI', N'JULIO JOSUE', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'170438', N'MAMANI-ZANABRIA', N'JEFERSSON', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'171569', N'QUISPE-HANCCO', N'FERNANDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'171676', N'HUAMAN-AYMA', N'DERLY HAYLEY', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'171879', N'QUISPE-MAMANI', N'THALIA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'174443', N'FARFAN-MOSCOSO', N'JUAN VICTOR', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'174445', N'OLARTE-CASAS', N'RODRIGO FABRICIO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'174449', N'SAIRE-BUSTAMANTE', N'EDMIL JAMPIER', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'174905', N'AGUILAR-MAINICTA', N'GIAN MARCO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'174948', N'HUAMAN-CHILO', N'ELVIS', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'175022', N'BAUTISTA-HURTADO', N'OWEN DEISER', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'175101', N'QUISPE-ESCALANTE', N'CARLA', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'182897', N'CALDERON-GARMENDIA', N'JOSEPH TIMOTHY', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'182913', N'HUAHUALUQUE-VARGAS', N'JHAMIL JHONATAN', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'182917', N'MAMANI-GABRIEL', N'BRUCE MAXIMO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'182932', N'QUISPE-QUISPE', N'JHON ALBERTH', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'182935', N'USCACHI-CCAPA', N'ERICK', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'182975', N'HUAYLLA-PEREDO', N'RUBEN DARIO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'182977', N'LA TORRE-FRANCO', N'JACOBO NEPTALY', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'183055', N'CARBAJAL-CARRASCO', N'GABRIEL', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'183067', N'HUAYLLA-HUILLCA', N'ROSSBEL', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'183078', N'PHUYO-HUAMAN', N'EDSON LEONID', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'183485', N'SULLCA-AQUINO', N'JOSE ANTONIO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184193', N'CCOSCCO-CHAHUA', N'YEISON EMERSON', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184194', N'CONDORCAHUA-AYLLONE', N'FERDINAN JUNIOR', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184195', N'CORDOVA-CCOPA', N'EMERSON', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184197', N'FERNANDEZ-BACA', N'CASTRO LUCIAN NEPTALI', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184201', N'GUTIERREZ-TAQQUERE', N'LUIS FERNANDO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184204', N'HUILLCA-QUISPE', N'JOEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184213', N'ZAVALA-TTITO', N'DORIAN ROGER', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184644', N'CCANCHI-CONDORI', N'ENMANUEL JESUS', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'184656', N'SUAREZ-MARISCAL', N'MARCELO EDUARDO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192190', N'ZUNIGA-SARA', N'CARLOS DANIEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192416', N'CCASANI-HUAMAN', N'WILMAN', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192417', N'CESPEDES-VILCA', N'ANGEL LUIS', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192418', N'CORNEJO-CASTRO', N'ANGELA LORENA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192420', N'GUEVARA-DELGADO', N'TIRSSA IVONNE', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192422', N'HUAMAN-QUISPE', N'ANDY MARCELO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192423', N'LOPEZ-BARAZORDA', N'JHON ANTHONY', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192425', N'MAYTA-SALAZAR', N'HERBERTH CLAUDD', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192426', N'NIÑO DE GUZMAN-CONDE', N'WENDEL YOVAN', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192427', N'PORTILLO-HUAMAN', N'ERICK NICASIO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192430', N'TTITO-QUISPE', N'ABELARDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'192665', N'FERNANDEZ-MANDURA', N'ROYER FUNACOSHI', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'193109', N'COLQUE-GALINDO', N'JEAN FRANCO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'194518', N'HUAMAN-JAIMES', N'NICANOR', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'194520', N'LLAMOCCA-QUISPE', N'FRANKLIN', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'194526', N'QUISPE-SALAS', N'JOSE ALEXANDER', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'194892', N'SONCCO-LUQUE', N'MAX ALEX', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'194916', N'BACILIO-HUAMAN', N'JEAN MARCO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'195036', N'GUEVARA-CUSI', N'ADRIEL MITHUAR', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'195048', N'LABRA-HUAITA', N'NAYELI CONSTANTINA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'195050', N'LOZANO-LLACCTAHUAMAN', N'MEDALY', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200330', N'AMAO-ATAUCHI', N'JULIO CESAR', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200332', N'CUSACANI-GONZALES', N'GERALD ANTONIO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200334', N'LIMA-ESPERILLA', N'KATERINE CANDY', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200336', N'ORCCON-DIAZ', N'DARCY OMAR', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200337', N'POMA-SUPO', N'JUAN GABRIEL', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200340', N'QUISPE-TAYÑA', N'JOSE LUIS', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200781', N'LIMPI-TINTA', N'IVAN NESTOR', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200785', N'OLARTE-BAUTISTA', N'CESAR CIRO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200788', N'SULLCARANI-DIAZ', N'BORIS ELOY', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200824', N'LEVITA-QUISPE', N'LUIS ALVINO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200825', N'MENDOZA-MAYTA', N'ANDRE MARCELO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200858', N'QUISPE-CONDORI', N'MANUEL EDUARDO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200865', N'YANA-CUNO', N'IAN PIERO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200878', N'HUAHUACHAMPI-HINOJOSA', N'ZAHID', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'200946', N'NINANCURO-HUARAYO', N'DIEGO SHAID', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'201229', N'ARANA-FLORES', N'SHAIEL ALMENDRA', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'201230', N'CABRERA-MEJIA', N'CRISTIAN ANDY', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'201231', N'CALLAÑAUPA-SALLO', N'JULIO CESAR', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204318', N'BELLIDO-ARMUTO', N'ABEL ENRIQUE', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204319', N'CONDORI-LACUTA', N'LUIS FERNANDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204320', N'GARCIA-ROMERO', N'JHONATAN ALEXANDER', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204321', N'NIETO-BARRIENTOS', N'YISHAR PIERO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204792', N'ACHAHUANCO-VALENZA', N'ANDREE', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204793', N'AGUILAR-SANCHEZ', N'NIK ANTONI', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204794', N'CCANSAYA-SONCCO', N'REBECA ARACELI', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204795', N'CHOQUE-QUISPE', N'JADYRA CHASKA', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204796', N'FARFAN-LUNA', N'JANNIRA ALISON', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204797', N'HANCCO-CHAMPI', N'FRAN ANTHONY', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204799', N'JALLO-PACCAYA', N'YASUMY MARICELY', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204800', N'MUÑOZ-CASTILLO', N'GEORGE IVANOK', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204801', N'OLIVARES-TORRES', N'YAQUELYN ROSALINDA', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204803', N'PACHARI-LIPA', N'MILTON ALEXIS', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204805', N'PUMACCAHUA-CUSIHUAMAN', N'CHRISTIAN', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204807', N'TINOCO-CCOTO', N'LUIS MANUEL', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'204808', N'TORREBLANCA-PAZ', N'SEBASTIAN VICTOR', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210178', N'LUNA-CCAPA', N'CARLOS WILLIAN', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210179', N'PRIETO-CARDOSO', N'DAVID FERNANDO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210180', N'VILLALOBOS-USCA', N'ANGHELO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210411', N'RAMOS-ALVAREZ', N'ISMAEL GERSON', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210412', N'ROMERO-BERNAL', N'JHAMSID', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210413', N'SANCHEZ-ENCISO', N'HORUS HUGO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210435', N'TICONA-QUISPE', N'ISEL YULIANA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210919', N'BIGGERSTAFF-PUMACAHUA', N'MEI LING', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210920', N'BUENO-LESCANO', N'ANDRIC JEREMY', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210921', N'CCAMA-ENRIQUEZ', N'CAROLAY', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210923', N'CCOYO-MEJIA', N'BRANDON', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210924', N'CUSI-DIAZ', N'IBETH JANELA DEL PILAR', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210926', N'DURAN-HUAMAN', N'YELSIN MAGIBEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210928', N'ESTRADA-CUYTO', N'BRANDON PAOLO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210929', N'GUTIERREZ-ALFARO', N'RONALD EINAR', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210930', N'HUAMAN-BERRIO', N'FRANZ PAUL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210931', N'KJUIRO-HUAMAN', N'HJOVER ELSON', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210933', N'MAMANI-JARA', N'JORGE LUIS', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210934', N'MAMANI-SALCEDO', N'LIZETH CARLA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210935', N'MERMA-CHURA', N'JEANPIER XILANDER', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210936', N'MONTAÑEZ-MEDINA', N'DANIEL', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210937', N'MOTTA-MENDOZA', N'PAVEL ALVARO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210939', N'PANTOJA-OLAVE', N'GUSTAVO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210940', N'PUMACHOQUE-CHOQUENAIRA', N'JHON ESAU', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'210942', N'RODRIGUEZ-PAUCCARA', N'CRISTIAN DIEGO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211265', N'CABEZA-HUILLCA', N'FLAVIO ANTONY', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211311', N'MAYTA-TTITO', N'WILL EDSON', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211355', N'AUCCACUSI-HUANCA', N'PAUL ANDRÉ', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211356', N'PALACIOS-DURAND', N'ORIOL FERNANDO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211358', N'QUISPE-HUILLCA', N'JOHAM ESAU', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211359', N'QUISPE-VENTURA', N'IAN LOGAN WILL', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211361', N'TORRE-CANO', N'EDUARDO', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211362', N'VALERIANO-HUACARPUMA', N'LUIGUI FERNANDO', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211363', N'YUCRA-MENDOZA', N'LISBETH', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211816', N'TICONA-JANCCO', N'RONALDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211818', N'YAPO-HUARAYA', N'FRAN JHOEL', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211855', N'HUACHO-CRUZ', N'DAVID ALI', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211856', N'HUAYAPA-HUAMANÑAHUI', N'OMAR', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211857', N'HUISA-NINA', N'YIMY YOHEL', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211858', N'MEZA-CHALLCO', N'DYLAN PATRICK', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211860', N'MUÑOZ-CENTENO', N'MILDER', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211862', N'QUISPE-ARQQUE', N'ETNER YURY', 7)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'211959', N'CCASA-POCOHUANCA', N'LUDVIKA ARLETH', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215270', N'ALEGRIA-SALLO', N'DANIEL', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215271', N'ALVARO-MENDOZA', N'VICTOR ANIBAL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215272', N'APAZA-MAMANI', N'GIANCARLO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215274', N'CHOQUEMAQUI-CHINCHERCOMA', N'FREDY JHON', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215275', N'COCHAMA-BORNAS', N'ORLANDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215277', N'HALANOCCA-SURCO', N'JHON KEVIN', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215278', N'HUISA-MAMANI', N'JUAN GABRIEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215279', N'RAMOS-CONDORI', N'LUCERO ESTEFANY', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215326', N'HUAYHUA-HUAMANI', N'JHON EBER', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215422', N'QUISPE-MACHACA', N'JHON JESUS', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215714', N'ANCASI-AYMACHOQUE', N'LUZ DIANA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215725', N'HIGUERA-HALANOCCA', N'BRAYAN ANTONI', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215780', N'ALEGRIA-MENDOZA', N'JESUS AUGUSTO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215781', N'BERRIOS-THEA', N'ALEX', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215783', N'CONDE-SALLO', N'JOHAN MIHAIL', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215784', N'CRUZ-YUCRA', N'LUCERO ESMERALDA', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215785', N'FERNANDEZ-PUMA', N'SEBASTIAN', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215786', N'LEON-MALDONADO', N'JOSE CARLOS', 6)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215788', N'PERALTA-OROS', N'KEVIN DANIEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215791', N'SOTELO-QUISPE', N'JULIO CESAR', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'215917', N'CHARALLA-CCAMA', N'GIAN FRANCO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'216061', N'HUILLCA-DIAZ', N'JOSE LUIS', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'216062', N'MUÑOZ-ROSAS', N'RAMIRO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220211', N'HANCCO-VALLE', N'LEO SMITH', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220212', N'NOA-ALLER', N'INGRID ROSARIO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220213', N'PUMACCAHUA-HUALLPA', N'PATRICK MICHAEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220214', N'VARGAS-ZEGARRA', N'MARCO ANTONIO AXEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220547', N'ARANIBAR-ROJAS', N'AXEL BARNABY', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220548', N'CASAFRANCA-BENAVIDES', N'ELVIS JAIR', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220549', N'LLANCAYA-TAPIA', N'ARACELY', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220552', N'QUISPE-CHECYA', N'JOAN GONZALO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220553', N'SUPA-CUSIPAUCAR', N'YEFERSON', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220554', N'ULLOA-PARQUE', N'FRANK WILDER', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220555', N'VILLAVICENCIO-SEGUIL', N'EDU PIERO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220610', N'QUISPE-LOCUMBER', N'ALDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220962', N'SALLUCA-CHILE', N'SANDRO ALEXANDER', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220963', N'SURCO-CUTIPA', N'LUIS ADRIAN', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'220964', N'TORRES-BAUTISTA', N'RONIL NILO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221443', N'CALDERON-RODRIGUEZ', N'ANDRE ALFREDO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221444', N'CCORI-TACO', N'ESMAYDES', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221445', N'CHILLIHUANI-HUAMAN', N'RIVALDO FRANCO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221446', N'DIAZ-MISME', N'PAMELA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221447', N'FARFAN-CARRION', N'JOSEPH MATTHEW', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221448', N'GIL-FIGUEROA', N'HEIDAN TORIBIO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221451', N'RODRÍGUEZ-CCOYTO', N'JAIRO JASER', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221452', N'TOLEDO-BERNAL', N'MAX ERIXON', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221945', N'ALVAREZ-CATUNTA', N'ANGEL ISMAEL', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221946', N'MAMANI-QUISPE', N'JUAN CARLOS', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221949', N'QUISPE-HUANCA', N'ANDY YOSEPH', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'221950', N'QUISPE-QUISPE', N'CELIA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'222067', N'CORAMPA-PALACIOS', N'ARACELY FIORELA', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'224874', N'QUISPE-MERMA', N'TIMOTEO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'225417', N'ARAPA-SALAZAR', N'MARCO ANTONIO', 5)
INSERT [dbo].[T_Estudiante] ([Id_Estudiante], [apellidos], [nombres], [semestre]) VALUES (N'225421', N'HUANCA-ALCCA', N'JHON WILLIAM', 5)

SET IDENTITY_INSERT [dbo].[T_Inscrito] ON
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (193, N'215780', N'ALEGRIA-MENDOZA', N'JESUS AUGUSTO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (195, N'215783', N'CONDE-SALLO', N'JOHAN MIHAIL', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (196, N'215784', N'CRUZ-YUCRA', N'LUCERO ESMERALDA', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (197, N'215785', N'FERNANDEZ-PUMA', N'SEBASTIAN', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (198, N'215786', N'LEON-MALDONADO', N'JOSE CARLOS', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (199, N'215788', N'PERALTA-OROS', N'KEVIN DANIEL', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (200, N'215791', N'SOTELO-QUISPE', N'JULIO CESAR', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (201, N'215917', N'CHARALLA-CCAMA', N'GIAN FRANCO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (202, N'216061', N'HUILLCA-DIAZ', N'JOSE LUIS', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (203, N'216062', N'MUÑOZ-ROSAS', N'RAMIRO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (204, N'220211', N'HANCCO-VALLE', N'LEO SMITH', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (205, N'220212', N'NOA-ALLER', N'INGRID ROSARIO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (206, N'220213', N'PUMACCAHUA-HUALLPA', N'PATRICK MICHAEL', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (207, N'220214', N'VARGAS-ZEGARRA', N'MARCO ANTONIO AXEL', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (208, N'220547', N'ARANIBAR-ROJAS', N'AXEL BARNABY', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (209, N'220548', N'CASAFRANCA-BENAVIDES', N'ELVIS JAIR', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (210, N'220549', N'LLANCAYA-TAPIA', N'ARACELY', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (211, N'220552', N'QUISPE-CHECYA', N'JOAN GONZALO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (212, N'220553', N'SUPA-CUSIPAUCAR', N'YEFERSON', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (213, N'220554', N'ULLOA-PARQUE', N'FRANK WILDER', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (214, N'220555', N'VILLAVICENCIO-SEGUIL', N'EDU PIERO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (215, N'220610', N'QUISPE-LOCUMBER', N'ALDO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (216, N'220962', N'SALLUCA-CHILE', N'SANDRO ALEXANDER', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (217, N'220963', N'SURCO-CUTIPA', N'LUIS ADRIAN', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (218, N'220964', N'TORRES-BAUTISTA', N'RONIL NILO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (219, N'221443', N'CALDERON-RODRIGUEZ', N'ANDRE ALFREDO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (220, N'221444', N'CCORI-TACO', N'ESMAYDES', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (221, N'221445', N'CHILLIHUANI-HUAMAN', N'RIVALDO FRANCO', "2024-I", "0")
INSERT [dbo].[T_Inscrito] ([Id_inscrito], [Id_Estudiante], [apellidos], [nombres], [periodo], [pago]) VALUES (234, N'225421', N'HUANCA-ALCCA', N'JHON WILLIAM', "2024-I", "0")

SET IDENTITY_INSERT [dbo].[T_Inscrito] OFF
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'021501', N'34527322')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'083221', N'89385546')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'090215', N'73255387')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'093178', N'33453578')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'101658', N'24159603')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'101659', N'83432616')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'101664', N'03269759')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'103647', N'58949682')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'110071', N'25514860')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'111864', N'39628556')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'113547', N'28503184')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'113562', N'81017632')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'114136', N'42070011')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'120893', N'61301210')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'120895', N'22101891')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'133962', N'61228536')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'134403', N'54764762')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'140997', N'64318726')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'141000', N'90844306')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'141010', N'29087821')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'141599', N'76575554')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'141664', N'59365838')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'141671', N'86386922')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'141677', N'31357747')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'143833', N'11412504')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'145003', N'43949304')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'150400', N'51015358')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'150401', N'43331077')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'154628', N'56533162')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'154635', N'58420729')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'160327', N'09957318')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'160696', N'55792634')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'161136', N'61928604')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'161534', N'57579387')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'163807', N'03311201')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'164244', N'47884709')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'164246', N'50697904')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'164563', N'95098482')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'170431', N'70883133')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'170433', N'07818297')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'170438', N'76197990')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'171569', N'29252030')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'171676', N'85048154')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'171879', N'62891956')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'174443', N'52212858')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'174445', N'08548719')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'174449', N'48231585')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'174905', N'07250993')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'174948', N'36098170')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'175022', N'02306169')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'175101', N'08526240')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'182897', N'36145071')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'182913', N'81017212')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'182917', N'02292789')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'182932', N'13424671')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'182935', N'19510240')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'182975', N'42140427')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'182977', N'72239576')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'183055', N'71325562')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'183067', N'49076928')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'183078', N'82405487')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'183485', N'06424316')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184193', N'19389159')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184194', N'59013417')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184195', N'93470703')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184197', N'35280380')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184201', N'73576487')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184204', N'75463635')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184213', N'57308464')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184644', N'99439691')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'184656', N'00409314')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192190', N'47053306')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192416', N'26220812')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192417', N'71869580')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192418', N'52532362')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192420', N'68514105')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192422', N'98024612')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192423', N'82275459')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192425', N'90917749')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192426', N'90623086')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192427', N'03714558')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192430', N'13400961')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'192665', N'35141972')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'193109', N'41340898')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'194518', N'46627454')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'194520', N'41042380')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'194526', N'35978351')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'194892', N'55621182')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'194916', N'45632438')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'195036', N'07999290')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'195048', N'23059100')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'195050', N'15627222')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200330', N'37067579')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200332', N'10603522')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200334', N'55980222')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200336', N'55277118')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200337', N'46612227')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200340', N'51484966')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200781', N'33612320')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200785', N'57112019')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200788', N'98668093')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200824', N'32398385')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200825', N'96445950')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200858', N'46650054')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200865', N'04963972')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200878', N'42800211')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'200946', N'95266630')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'201229', N'25114322')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'201230', N'68834129')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'201231', N'81920502')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204318', N'44658983')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204319', N'09378580')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204320', N'96313877')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204321', N'23747197')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204792', N'59797737')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204793', N'95258502')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204794', N'29331886')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204795', N'79241469')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204796', N'95288922')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204797', N'26285287')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204799', N'24177557')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204800', N'11185955')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204801', N'93523243')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204803', N'60156005')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204805', N'04162813')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204807', N'05777473')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'204808', N'06926540')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210178', N'07074011')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210179', N'06707820')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210180', N'11284652')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210411', N'37490885')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210412', N'01548480')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210413', N'46617651')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210435', N'49043653')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210919', N'28375101')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210920', N'71962717')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210921', N'32480347')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210923', N'12518424')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210924', N'52201142')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210926', N'54467986')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210928', N'73102638')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210929', N'36526832')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210930', N'95004151')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210931', N'71258892')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210933', N'48442128')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210934', N'83656257')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210935', N'01628815')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210936', N'70303795')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210937', N'62884808')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210939', N'21215045')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210940', N'65471746')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'210942', N'68628150')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211265', N'40943721')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211311', N'18965007')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211355', N'57482238')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211356', N'82152790')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211358', N'61640028')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211359', N'22538705')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211361', N'89607681')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211362', N'60515794')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211363', N'88044564')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211816', N'55507091')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211818', N'25730830')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211855', N'35804035')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211856', N'31597512')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211857', N'22520746')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211858', N'04899639')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211860', N'50187694')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211862', N'10764946')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'211959', N'45083095')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215270', N'01902366')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215271', N'75464255')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215272', N'21000711')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215274', N'02546464')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215275', N'05857928')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215277', N'30895711')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215278', N'94610842')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215279', N'98998292')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215326', N'90594982')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215422', N'82609253')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215714', N'04418432')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215725', N'15690291')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215780', N'05041260')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215781', N'63281436')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215783', N'26847844')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215784', N'63793926')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215785', N'25932028')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215786', N'74541507')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215788', N'19734532')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215791', N'15874766')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'215917', N'16564041')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'216061', N'30632930')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'216062', N'20742817')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220211', N'26162430')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220212', N'78249421')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220213', N'45048991')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220214', N'27449243')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220547', N'48378798')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220548', N'65537818')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220549', N'85968782')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220552', N'79440915')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220553', N'39910437')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220554', N'61734544')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220555', N'66533857')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220610', N'01083486')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220962', N'40978073')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220963', N'22969481')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'220964', N'50833715')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221443', N'42083442')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221444', N'21835756')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221445', N'91119875')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221446', N'39326526')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221447', N'94259808')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221448', N'87386457')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221451', N'41416066')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221452', N'55541167')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221945', N'81414961')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221946', N'13324899')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221949', N'35740108')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'221950', N'86043566')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'222067', N'06040435')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'224874', N'53036416')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'225417', N'66153167')
INSERT [dbo].[T_Usuario] ([Id_Estudiante], [Contraseña]) VALUES (N'225421', N'15379276')

CREATE TABLE T_Pagos (
    Id_Pago varchar(50),
    Id_Estudiante varchar(50),
    Nro_Tarjeta varchar(50),
    CVC varchar(3),
    Fecha date,
    Periodo varchar(50),
    CONSTRAINT PK_T_Pagos PRIMARY KEY (Id_Pago, Id_Estudiante, Nro_Tarjeta, CVC, Fecha, Periodo)
);

USE [master]
ALTER DATABASE [EstudiantesDB] SET  READ_WRITE
