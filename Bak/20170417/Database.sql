USE [master]
GO
/****** Object:  Database [Cube]    Script Date: 03/25/2017 00:10:40 ******/
CREATE DATABASE [Cube] ON  PRIMARY 
( NAME = N'Cube', FILENAME = N'f:\SQL Server Data Files\CIM\Cube.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cube_log', FILENAME = N'f:\SQL Server Data Files\CIM\Cube_log.LDF' , SIZE = 504KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [Cube] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cube].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cube] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Cube] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Cube] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Cube] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Cube] SET ARITHABORT OFF
GO
ALTER DATABASE [Cube] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Cube] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Cube] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Cube] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Cube] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Cube] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Cube] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Cube] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Cube] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Cube] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Cube] SET  DISABLE_BROKER
GO
ALTER DATABASE [Cube] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Cube] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Cube] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Cube] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Cube] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Cube] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Cube] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Cube] SET  READ_WRITE
GO
ALTER DATABASE [Cube] SET RECOVERY SIMPLE
GO
ALTER DATABASE [Cube] SET  MULTI_USER
GO
ALTER DATABASE [Cube] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Cube] SET DB_CHAINING OFF
GO
USE [Cube]
GO
/****** Object:  Table [dbo].[cb_user_role]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_user_role](
	[user_id] [uniqueidentifier] NOT NULL,
	[role_id] [uniqueidentifier] NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_user_role] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_user_function]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_user_function](
	[user_id] [uniqueidentifier] NOT NULL,
	[function_id] [uniqueidentifier] NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_user_function] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[function_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_user]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_user](
	[id] [uniqueidentifier] NOT NULL,
	[login_name] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[mail] [nvarchar](250) NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_token]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_token](
	[user_id] [uniqueidentifier] NOT NULL,
	[login_time] [datetime] NOT NULL,
	[secret_key] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_cb_token] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_system_parameter]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_system_parameter](
	[id] [uniqueidentifier] NOT NULL,
	[system_id] [uniqueidentifier] NOT NULL,
	[function_id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[value] [nvarchar](250) NOT NULL,
	[description] [nvarchar](250) NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_system_parameter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_system_group]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_system_group](
	[id] [uniqueidentifier] NOT NULL,
	[domian_id] [uniqueidentifier] NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[language_key] [nvarchar](200) NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_system_group] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_system]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_system](
	[id] [uniqueidentifier] NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[description] [nvarchar](250) NULL,
	[domian_id] [uniqueidentifier] NULL,
	[group_id] [uniqueidentifier] NULL,
	[language_key] [nvarchar](200) NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_system] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_role_function]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_role_function](
	[role_id] [uniqueidentifier] NOT NULL,
	[function_id] [uniqueidentifier] NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_role_function] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[function_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_role]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_role](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_preference]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_preference](
	[user_id] [uniqueidentifier] NOT NULL,
	[language_key] [nvarchar](200) NULL,
	[skin] [nvarchar](200) NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_preference] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_plugin]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_plugin](
	[plugin_name] [nvarchar](250) NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_plugin] PRIMARY KEY CLUSTERED 
(
	[plugin_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_message_send]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cb_message_send](
	[id] [uniqueidentifier] NOT NULL,
	[message_id] [uniqueidentifier] NOT NULL,
	[user_id] [uniqueidentifier] NOT NULL,
	[is_read] [varchar](1) NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_message_send] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cb_message]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_message](
	[id] [uniqueidentifier] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
	[message_content] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_cb_message] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_language]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_language](
	[language_key] [nvarchar](200) NOT NULL,
	[zh_cn] [nvarchar](max) NULL,
	[zh_tw] [nvarchar](max) NULL,
	[en_us] [nvarchar](max) NULL,
	[createed_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_language] PRIMARY KEY CLUSTERED 
(
	[language_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_function]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_function](
	[id] [uniqueidentifier] NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[system_id] [nvarchar](200) NOT NULL,
	[parent_function_id] [nvarchar](200) NULL,
	[language_key] [nvarchar](250) NULL,
	[url] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_function] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_domain]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_domain](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](250) NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_domain] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_bookmark]    Script Date: 03/25/2017 00:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_bookmark](
	[user_id] [uniqueidentifier] NOT NULL,
	[function_id] [uniqueidentifier] NOT NULL,
	[created_at] [datetime] NULL,
	[created_by] [nvarchar](50) NULL,
	[modified_at] [datetime] NULL,
	[modified_by] [nvarchar](50) NULL,
 CONSTRAINT [PK_cb_bookmark] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[function_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
