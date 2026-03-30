USE [master]
GO
/****** Object:  Database [BasicDb]    Script Date: 30-03-2026 16:38:12 ******/
CREATE DATABASE [BasicDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BasicDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BasicDb.mdf' , SIZE = 335872KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BasicDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BasicDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BasicDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BasicDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BasicDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BasicDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BasicDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BasicDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BasicDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [BasicDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BasicDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BasicDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BasicDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BasicDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BasicDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BasicDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BasicDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BasicDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BasicDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BasicDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BasicDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BasicDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BasicDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BasicDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BasicDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BasicDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BasicDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BasicDb] SET  MULTI_USER 
GO
ALTER DATABASE [BasicDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BasicDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BasicDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BasicDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BasicDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BasicDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BasicDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [BasicDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BasicDb]
GO
/****** Object:  UserDefinedTableType [dbo].[AttachmentType]    Script Date: 30-03-2026 16:38:12 ******/
CREATE TYPE [dbo].[AttachmentType] AS TABLE(
	[Original_Name] [nvarchar](255) NULL,
	[File_Name] [nvarchar](255) NULL,
	[File_Path] [nvarchar](500) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[IntListType]    Script Date: 30-03-2026 16:38:12 ******/
CREATE TYPE [dbo].[IntListType] AS TABLE(
	[Id] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[InvoiceLineType]    Script Date: 30-03-2026 16:38:12 ******/
CREATE TYPE [dbo].[InvoiceLineType] AS TABLE(
	[item_name] [varchar](50) NULL,
	[description] [varchar](50) NULL,
	[inv_line_identifier] [varchar](50) NULL,
	[unit_of_measure_code] [varchar](10) NULL,
	[net_amt] [decimal](18, 6) NULL,
	[item_net_price] [decimal](18, 6) NULL,
	[item_gross_price] [decimal](18, 6) NULL,
	[item_price_base_qty] [int] NULL,
	[item_tax_cat_code] [varchar](10) NULL,
	[item_tax_rate] [decimal](18, 6) NULL,
	[vat_in_aed] [decimal](18, 6) NULL,
	[amt_in_aed] [decimal](18, 6) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[PermissionIdTableType]    Script Date: 30-03-2026 16:38:12 ******/
CREATE TYPE [dbo].[PermissionIdTableType] AS TABLE(
	[PermissionId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[QuoteLineType]    Script Date: 30-03-2026 16:38:12 ******/
CREATE TYPE [dbo].[QuoteLineType] AS TABLE(
	[st_id] [int] NULL,
	[pd_id] [int] NULL,
	[module_id] [int] NULL,
	[rate] [decimal](18, 3) NULL,
	[license_count] [int] NULL
)
GO
/****** Object:  Table [dbo].[AppLogs]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[MessageTemplate] [nvarchar](max) NULL,
	[Level] [nvarchar](50) NULL,
	[TimeStamp] [datetime2](7) NOT NULL,
	[Exception] [nvarchar](max) NULL,
	[Properties] [nvarchar](max) NULL,
	[CorrelationId] [nvarchar](100) NULL,
	[UserName] [nvarchar](200) NULL,
	[IPAddress] [nvarchar](50) NULL,
	[RequestPath] [nvarchar](500) NULL,
	[MachineName] [nvarchar](200) NULL,
	[ThreadId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[cat_Id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NULL,
	[name] [varchar](30) NULL,
	[description] [varchar](max) NULL,
	[st_Id] [int] NULL,
	[created_by] [int] NULL,
	[created_on] [datetime] NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[cat_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[company_id] [int] NOT NULL,
	[name] [varchar](10) NOT NULL,
	[address_line] [varchar](max) NOT NULL,
	[city] [varchar](10) NOT NULL,
	[country_subdivision] [varchar](10) NOT NULL,
	[country] [varchar](10) NOT NULL,
	[zip_code] [varchar](10) NOT NULL,
	[contact_person] [varchar](10) NOT NULL,
	[contact_email] [varchar](50) NOT NULL,
	[contact_number] [varchar](10) NOT NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[currency] [varchar](10) NOT NULL,
	[decimalplace] [int] NOT NULL,
	[taxlimit] [int] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](max) NULL,
	[email] [varchar](150) NULL,
	[contact_person] [varchar](50) NULL,
	[mobile_no] [varchar](10) NULL,
	[customer_type_id] [int] NULL,
	[addressline1] [varchar](150) NULL,
	[city] [varchar](50) NULL,
	[country_subdivision] [varchar](50) NULL,
	[country] [varchar](50) NULL,
	[zip_code] [varchar](10) NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_Type]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Type](
	[ct_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[description] [varchar](max) NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_Customer_type] PRIMARY KEY CLUSTERED 
(
	[ct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomMenu]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomMenu](
	[cus_menu_id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[menu_id] [int] NULL,
	[is_enabled] [bit] NULL,
 CONSTRAINT [PK_CustomMenu] PRIMARY KEY CLUSTERED 
(
	[cus_menu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLogs]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Level] [nvarchar](20) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Exception] [nvarchar](max) NULL,
	[TimeStamp] [datetime2](7) NOT NULL,
	[UserName] [nvarchar](200) NULL,
	[RequestPath] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[License_Mode]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[License_Mode](
	[lm_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](20) NULL,
	[name] [varchar](20) NOT NULL,
	[description] [varchar](max) NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_ALF_License_Mode] PRIMARY KEY CLUSTERED 
(
	[lm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[License_Type]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[License_Type](
	[lt_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](20) NULL,
	[name] [varchar](20) NOT NULL,
	[description] [varchar](max) NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_License_Type] PRIMARY KEY CLUSTERED 
(
	[lt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[menu_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[parent_id] [int] NULL,
	[display_order] [int] NOT NULL,
	[icon] [varchar](25) NULL,
	[link] [varchar](25) NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[menu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[prm_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
	[label] [nvarchar](100) NULL,
	[parent] [nvarchar](100) NULL,
	[created_on] [datetime] NULL,
	[created_by] [int] NOT NULL,
	[updated_on] [datetime] NULL,
	[updated_by] [int] NULL,
	[is_deleted] [bit] NULL,
 CONSTRAINT [PK__Permissi__5CA4C4E1EC1A1FA7] PRIMARY KEY CLUSTERED 
(
	[prm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__Permissi__737584F6572A56A3] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PriceList]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceList](
	[pl_id] [int] IDENTITY(1,1) NOT NULL,
	[st_id] [int] NOT NULL,
	[cat_id] [int] NOT NULL,
	[pd_id] [int] NULL,
	[lt_id] [int] NULL,
	[lm_id] [int] NULL,
	[unit_rate] [decimal](18, 2) NOT NULL,
	[alf_rate] [decimal](5, 2) NULL,
	[effective_from] [date] NULL,
	[effective_to] [date] NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[pd_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](max) NULL,
	[cat_id] [int] NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_ALF_License_Type] PRIMARY KEY CLUSTERED 
(
	[pd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quote_Attachments]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quote_Attachments](
	[q_file_id] [int] IDENTITY(1,1) NOT NULL,
	[q_id] [int] NOT NULL,
	[original_name] [varchar](max) NULL,
	[file_name] [varchar](max) NULL,
	[file_path] [varchar](max) NULL,
	[created_by] [int] NULL,
	[created_on] [datetime] NULL,
 CONSTRAINT [PK_Quote_Files] PRIMARY KEY CLUSTERED 
(
	[q_file_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quote_Header]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quote_Header](
	[q_id] [int] IDENTITY(1,1) NOT NULL,
	[quote_no] [varchar](20) NULL,
	[quote_date] [date] NULL,
	[customer_id] [int] NULL,
	[total_amt] [decimal](18, 3) NULL,
	[discount] [decimal](18, 3) NULL,
	[net_amt] [decimal](18, 3) NULL,
	[increased_rate] [int] NULL,
	[t_c] [varchar](max) NULL,
	[quote_send] [bit] NOT NULL,
	[contract_signed] [bit] NOT NULL,
	[invoiced] [bit] NOT NULL,
	[payment_received] [bit] NOT NULL,
	[created_by] [int] NULL,
	[created_on] [datetime] NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Quote_Header] PRIMARY KEY CLUSTERED 
(
	[q_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quote_Line]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quote_Line](
	[q_line_id] [int] IDENTITY(1,1) NOT NULL,
	[q_id] [int] NOT NULL,
	[st_id] [int] NULL,
	[pd_id] [int] NULL,
	[module_id] [int] NULL,
	[rate] [decimal](18, 3) NULL,
	[license_count] [int] NULL,
	[line_no] [int] NOT NULL,
 CONSTRAINT [PK_Quote_Line] PRIMARY KEY CLUSTERED 
(
	[q_line_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshTokens](
	[RefreshTokenId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Token] [nvarchar](500) NOT NULL,
	[ExpiryDate] [datetime2](7) NOT NULL,
	[IsRevoked] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RefreshTokenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermissions]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermissions](
	[rp_id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[prm_id] [int] NOT NULL,
 CONSTRAINT [PK__RolePerm__73C32982B0D3DA75] PRIMARY KEY CLUSTERED 
(
	[rp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
	[created_on] [datetime] NULL,
	[created_by] [int] NOT NULL,
	[updated_on] [datetime] NULL,
	[updated_by] [int] NULL,
	[is_deleted] [bit] NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service_Type]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service_Type](
	[st_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NOT NULL,
	[name] [varchar](20) NOT NULL,
	[description] [varchar](max) NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_Service_Type] PRIMARY KEY CLUSTERED 
(
	[st_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitOfMeasure]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitOfMeasure](
	[uom_Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](20) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](255) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[uom_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](150) NULL,
	[email] [varchar](150) NULL,
	[mobile_number] [varchar](15) NULL,
	[user_name] [nvarchar](50) NULL,
	[password] [nvarchar](max) NULL,
	[role_id] [int] NULL,
	[created_by] [int] NULL,
	[created_on] [datetime] NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Logs_CorrelationId]    Script Date: 30-03-2026 16:38:12 ******/
CREATE NONCLUSTERED INDEX [IX_Logs_CorrelationId] ON [dbo].[AppLogs]
(
	[CorrelationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Logs_Level]    Script Date: 30-03-2026 16:38:12 ******/
CREATE NONCLUSTERED INDEX [IX_Logs_Level] ON [dbo].[AppLogs]
(
	[Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Logs_TimeStamp]    Script Date: 30-03-2026 16:38:12 ******/
CREATE NONCLUSTERED INDEX [IX_Logs_TimeStamp] ON [dbo].[AppLogs]
(
	[TimeStamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Logs_TimeStamp]    Script Date: 30-03-2026 16:38:12 ******/
CREATE NONCLUSTERED INDEX [IX_Logs_TimeStamp] ON [dbo].[ErrorLogs]
(
	[TimeStamp] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Product_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Product_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_name]  DEFAULT ('') FOR [name]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Customer_Type] ADD  CONSTRAINT [DF_Customer_type_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Customer_Type] ADD  CONSTRAINT [DF_Customer_type_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  DEFAULT (getutcdate()) FOR [TimeStamp]
GO
ALTER TABLE [dbo].[License_Mode] ADD  CONSTRAINT [DF_License_Mode_created_by]  DEFAULT ((1)) FOR [created_by]
GO
ALTER TABLE [dbo].[License_Mode] ADD  CONSTRAINT [DF_License_Mode_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[License_Mode] ADD  CONSTRAINT [DF_License_Mode_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[License_Type] ADD  CONSTRAINT [DF_License_Type_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[License_Type] ADD  CONSTRAINT [DF_License_Type_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Menu] ADD  CONSTRAINT [DF_Menu_display_order]  DEFAULT ((0)) FOR [display_order]
GO
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF__Permissio__creat__02925FBF]  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF__Permissio__is_de__038683F8]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[PriceList] ADD  CONSTRAINT [DF_PriceList_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[PriceList] ADD  CONSTRAINT [DF_PriceList_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_ALF_License_Type_created_by]  DEFAULT ((1)) FOR [created_by]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_ALF_License_Type_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_ALF_License_Type_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Quote_Header] ADD  CONSTRAINT [DF_Quote_Header_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Quote_Line] ADD  CONSTRAINT [DF__Quote_L__line___29221CFB]  DEFAULT ((1)) FOR [line_no]
GO
ALTER TABLE [dbo].[RefreshTokens] ADD  DEFAULT ((0)) FOR [IsRevoked]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Service_Type] ADD  CONSTRAINT [DF_Service_Type_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Service_Type] ADD  CONSTRAINT [DF_Service_Type_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[UnitOfMeasure] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UnitOfMeasure] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__IsDeleted__4D94879B]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_is_active]  DEFAULT ((1)) FOR [is_active]
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Category_Delete]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE Category
    SET 
        is_deleted = 1
    WHERE cat_Id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Category_GetAll]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;
	if(@id=0)
    SELECT p.cat_Id,p.name,p.code,p.description,p.st_id,p.is_active,s.name as ServiceType
    FROM Category p
	join Service_Type s on s.st_id=p.st_id
	where p.is_deleted = 0
    ORDER BY p.cat_Id ASC;
	else
	SELECT p.cat_Id,p.name,p.code,p.description,p.st_id,p.is_active,s.name as ServiceType
    FROM Category p
	join Service_Type s on s.st_id=p.st_id
	where p.is_deleted = 0 and p.st_id=@id
    ORDER BY p.cat_Id ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Insert]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Category_Insert]
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@st_Id INT,
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO Category
    (
        code
      ,name
      ,description
      ,st_Id
      ,created_by
      ,created_on
    )
    VALUES
    (
        @Code,
		@Name,
		@Description,
		@st_Id,
        @CreatedBy,
        @CreatedOn
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_Category_Toggle]
(
    @Id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Category
    WHERE cat_Id = @Id;

    UPDATE Category
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE cat_Id = @Id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Category_Update]
(
    @cat_id int,
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@st_Id INT,
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Category
    SET
        name = @name,
        code = @Code,
        description = @Description,
        st_Id = @st_Id,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE cat_Id = @cat_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Company_GetById]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Company_GetById]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Company
    WHERE company_id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Company_Menu]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_Company_Menu]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

   select m.menu_id,m.name,m.display_order,m.parent_id,m.icon,m.link from Menu m join CustomMenu c on m.menu_id=c.menu_id 
   WHERE company_id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Customer_Delete]
(
    @customer_id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE Customer
    SET 
        is_deleted = 1
    WHERE customer_id = @customer_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Customer_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Customer
	where is_deleted = 0
    ORDER BY customer_id asc;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_GetById]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Customer_GetById]
(
    @customer_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Customer
    WHERE customer_id = @customer_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Insert]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Customer_Insert]
(
	@code varchar(10),
	@customer_type_id int,
    @name varchar(50),
	@description varchar(max),
    @contact_person varchar(50),
    @email varchar(150),
    @mobile_Number varchar(10),
    @addressline1 varchar(50),
    @city varchar(50),
    @country_subdivision varchar(50),
    @country varchar(50),
	@zip_code varchar(10),
	@CreatedBy int,
    @CreatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Customer
    (
        name,
		code,
		description,
		customer_type_id,
        contact_person,
        email,
        mobile_no,
        addressline1,
        city,
        country_subdivision,
        country,
		zip_code,
        created_by,
		created_on
    )
    VALUES
    (
        @name,
		@code,
		@description,
		@customer_type_id,
        @contact_person,
        @email,
        @mobile_Number,
        @addressline1,
        @city,
        @country_subdivision,
        @country,
		@zip_code,
        @CreatedBy,
		@CreatedOn
    );

    SELECT SCOPE_IDENTITY() AS customer_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[sp_Customer_Toggle]
(
    @customer_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Customer
     WHERE customer_id = @customer_id;

    UPDATE Customer
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
     WHERE customer_id = @customer_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Customer_Type_Delete]
(
    @ct_id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE Customer_Type
    SET 
        is_deleted = 1
    WHERE ct_id = @ct_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Customer_Type_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Customer_Type
	where is_deleted = 0
    ORDER BY ct_id asc;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_GetById]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Customer_Type_GetById]
(
    @ct_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Customer_Type
    WHERE ct_id = @ct_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Insert]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_Customer_Type_Insert]
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO Customer_Type
    (
        code
      ,name
      ,description
      ,created_by
      ,created_on
    )
    VALUES
    (
        @Code,
		@Name,
		@Description,
        @CreatedBy,
        @CreatedOn
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_Customer_Type_Toggle]
(
    @ct_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Customer_Type
    WHERE ct_id = @ct_id;

    UPDATE Customer_Type
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE ct_id = @ct_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Customer_Type_Update]
(
    @ct_id int,
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Customer_Type
    SET
        name = @name,
        code = @Code,
        description = @Description,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE ct_id = @ct_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Customer_Update]
(
    @customer_id int,
	@code varchar(10),
	@customer_type_id int,
    @name varchar(50),
	@description varchar(max),
    @contact_person varchar(50),
    @email varchar(150),
    @mobile_number varchar(10),
    @addressline1 varchar(50),
    @city varchar(50),
    @country_subdivision varchar(50),
    @country varchar(50),
	@zip_code varchar(10),
    @UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Customer
    SET
        name = @name,
		code=@code,
		description=@description,
		customer_type_id=@customer_type_id,
        contact_person = @contact_person,
        email = @email,
        mobile_no = @mobile_number,
        addressline1 = @addressline1,
        city = @city,
        country_subdivision = @country_subdivision,
        country = @country,
		zip_code=@zip_code,
        updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE customer_id = @customer_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRefreshToken]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetRefreshToken]
    @Token NVARCHAR(500)
AS
BEGIN
    SELECT *
    FROM RefreshTokens
    WHERE Token = @Token
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Mode_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_License_Mode_Delete]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE License_Mode
    SET 
        is_deleted = 1
    WHERE lm_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Mode_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_License_Mode_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM License_Mode
	where is_deleted = 0
    ORDER BY lm_id asc;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Mode_Insert]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_License_Mode_Insert]
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO License_Mode
    (
        code
      ,name
      ,description
      ,created_by
      ,created_on
    )
    VALUES
    (
        @Code,
		@Name,
		@Description,
        @CreatedBy,
        @CreatedOn
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Mode_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_License_Mode_Toggle]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM License_Mode
    WHERE lm_id = @id;

    UPDATE License_Mode
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE lm_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Mode_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_License_Mode_Update]
(
    @lm_id int,
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE License_Mode
    SET
        name = @name,
        code = @Code,
        description = @Description,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE lm_id = @lm_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Type_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_License_Type_Delete]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE License_Type
    SET 
        is_deleted = 1
    WHERE lt_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Type_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_License_Type_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM License_Type
	where is_deleted = 0
    ORDER BY lt_id asc;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Type_Insert]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_License_Type_Insert]
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO License_Type
    (
        code
      ,name
      ,description
      ,created_by
      ,created_on
    )
    VALUES
    (
        @Code,
		@Name,
		@Description,
        @CreatedBy,
        @CreatedOn
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Type_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_License_Type_Toggle]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM License_Type
    WHERE lt_id = @id;

    UPDATE License_Type
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE lt_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_License_Type_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_License_Type_Update]
(
    @lt_id int,
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE License_Type
    SET
        name = @name,
        code = @Code,
        description = @Description,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE lt_id = @lt_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PriceList_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_PriceList_Delete]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE PriceList
    SET 
        is_deleted = 1
    WHERE pl_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PriceList_Filtered]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_PriceList_Filtered]
(
    @pd_id int,
	@customer_id int,
	@st_id int,
	@module_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Custom_Price
    WHERE custom_prod_id = @customer_id and pd_id=@pd_id and st_id=@st_id and module_id=@module_id and is_deleted=0;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PriceList_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_PriceList_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.pl_id, p.[st_id]
      ,p.[cat_id]
      ,p.[pd_id]
      ,p.[lt_id]
      ,p.[lm_id]
      ,p.[unit_rate]
      ,p.[alf_rate]
      ,p.[effective_from]
      ,p.[effective_to]
	  ,p.is_active
	,s.Name as ServiceType,c.Name as Category, l.Name as Product, t.name as LicenseType,m.name as LicenseMode
    FROM PriceList p
	join Service_Type s on s.st_id=p.st_id
	join Category c on c.cat_Id=p.cat_id
	join Products l on l.pd_Id=p.pd_id
	left join License_Type t on t.lt_id=p.lt_id
	left join License_Mode m on m.lm_id=p.lm_id
	where p.is_deleted = 0
    ORDER BY p.pl_id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PriceList_Insert]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_PriceList_Insert]
(
	@st_id int,
	@cat_id int,
	@pd_id int,
	@lt_id int,
	@lm_id int,
	@unit_rate decimal(18,3),
	@alf_rate decimal(18,3),
	@effective_from Datetime,
	@effective_to Datetime,
	@CreatedBy int,
    @CreatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO PriceList
    (	st_id,
		cat_id,
		pd_id,
        lt_id,
        lm_id,
        unit_rate,
        alf_rate,
		effective_from,
		effective_to,
		created_by,
		created_on
    )
    VALUES
    (	@st_id,
		@cat_id,
		@pd_id,
        @lt_id,
        @lm_id,
        @unit_rate,
        @alf_rate,
		@effective_from,
		@effective_to,
		@CreatedBy,
		@CreatedOn
    );

    SELECT SCOPE_IDENTITY() AS pl_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PriceList_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[sp_PriceList_Toggle]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM PriceList
     WHERE pl_id = @id;

    UPDATE PriceList
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
     WHERE pl_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_PriceList_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_PriceList_Update]
(	@pl_id int,
	@st_id int,
	@cat_id int,
	@pd_id int,
	@lt_id int,
	@lm_id int,
	@unit_rate decimal(18,3),
	@alf_rate decimal(18,3),
	@effective_from Datetime,
	@effective_to Datetime,
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE PriceList
    SET
       st_id=@st_id,
	   cat_id=@cat_id,
	   pd_id=@pd_id,
	   lt_id=@lt_id,
	   lm_id=@lm_id,
	   unit_rate=@unit_rate,
	   alf_rate=@alf_rate,
	   effective_from=@effective_from,
	  effective_to=@effective_to,
	   updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE pl_id = @pl_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_Product_Delete]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE Products
    SET 
        is_deleted = 1
    WHERE pd_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_Product_GetAll]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;
	if(@id=0)
    SELECT *
    FROM Products
	where is_deleted = 0
    ORDER BY pd_id asc;
	else
	SELECT *
    FROM Products
	where is_deleted = 0 and cat_id=@id
    ORDER BY pd_id asc;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Insert]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_Product_Insert]
    @Code VARCHAR(10),
	@Name VARCHAR(50),
	@Description VARCHAR(500),
	@Cat_Id int,
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO Products
    (
        code
      ,name
      ,description
	  ,cat_id
      ,created_by
      ,created_on
    )
    VALUES
    (
        @Code,
		@Name,
		@Description,
		@Cat_Id,
        @CreatedBy,
        @CreatedOn
    );
    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_Product_Toggle]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Products
    WHERE pd_id = @id;

    UPDATE Products
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE pd_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_Product_Update]
(
    @pd_id int,
    @Code VARCHAR(10),
	@Name VARCHAR(50),
	@Description VARCHAR(500),
	@cat_Id int,
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Products
    SET
        name = @name,
        code = @Code,
		cat_id=@cat_Id,
        description = @Description,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE pd_id = @pd_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quote_Attachments_Save]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Quote_Attachments_Save]
(
    @q_id INT,
    @Created_By INT,
    @Created_On DATETIME,

    @DeletedIds IntListType READONLY,   -- ✅ fixed
    @Files AttachmentType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        -- 🔥 DELETE LOGIC
        IF EXISTS (SELECT 1 FROM @DeletedIds)
        BEGIN
            -- ✅ delete only selected
            DELETE FROM Quote_Attachments
            WHERE q_id = @q_id
              AND q_file_id IN (SELECT Id FROM @DeletedIds);
        END

        -- 🔥 INSERT NEW FILES
        INSERT INTO Quote_Attachments
        (
            q_id,
            created_by,
            created_on,
            original_name,
            file_name,
            file_path
        )
        SELECT 
            @q_id,
            @Created_By,
            @Created_On,
            Original_Name,
            File_Name,
            File_Path
        FROM @Files;

        COMMIT;

        SELECT 1 AS Success;

    END TRY
    BEGIN CATCH
        ROLLBACK;

        SELECT 0 AS Success,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quote_Create]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Quote_Create]
(
    @quote_no varchar(20),
	@quote_date date,
	@customer_id int,
	@total_amt decimal(18, 6) ,
	@discount decimal(18, 6) ,
	@net_amt decimal(18, 6) ,
	@increased_rate int ,
	@t_c varchar(MAX) ,
	@quote_send bit ,
	@contract_signed bit ,
	@invoiced bit ,
	@payment_received bit ,
	@created_by int ,
	@created_on datetime ,
    @Lines dbo.QuoteLineType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRAN;

    INSERT INTO Quote_Header
   ([quote_no]
           ,[quote_date]
           ,[customer_id]
           ,[total_amt]
           ,[discount]
           ,[net_amt]
           ,[increased_rate]
           ,[t_c]
           ,[quote_send]
           ,[contract_signed]
           ,[invoiced]
           ,[payment_received]
           ,[created_by]
           ,[created_on])
    VALUES
    (
        @quote_no,@quote_date,@customer_id,@total_amt,@discount,@net_amt,@increased_rate,@t_c,@quote_send,
		@contract_signed,@invoiced,@payment_received,@created_by,@created_on
    );

    DECLARE @QuoteId INT = SCOPE_IDENTITY();

	;WITH LineCTE AS
(
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS RowNum
    FROM @Lines
)
INSERT INTO Quote_Line
([q_id]
           ,[st_id]
           ,[pd_id]
           ,[module_id]
           ,[rate]
           ,[license_count]
           ,[line_no])
SELECT
    @QuoteId,
    st_id,
    pd_id,
    module_id,
    rate,
    license_count,
	RowNum
    
FROM LineCTE;
    COMMIT;

    SELECT @QuoteId AS q_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quote_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Quote_Delete]
(
    @q_id INT
)
AS
BEGIN
    BEGIN TRAN;

    DELETE FROM Quote_Line
    WHERE q_id = @q_id;

    Update  Quote_Header Set is_deleted=1
    WHERE q_id = @q_id;

    COMMIT;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quote_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Quote_GetAll]
AS
BEGIN
 SELECT [q_id]
      ,[quote_no]
      ,[quote_date]
      ,[net_amt]
      ,[quote_send]
      ,[contract_signed]
      ,[invoiced]
      ,[payment_received]
	  ,b.name as Customer
  FROM [BasicDb].[dbo].[Quote_Header] i join Customer b on b.customer_id=i.customer_id where i.is_deleted=0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quote_GetById]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Quote_GetById]
(
    @q_id INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * 
    FROM Quote_Header
    WHERE q_Id = @q_id;

    SELECT *
    FROM Quote_Line
    WHERE q_id = @q_id;

	SELECT [q_file_id] as id,
		[q_file_id]
      ,[q_id]
      ,[original_name]
      ,[file_name]
      ,[file_path]
    FROM Quote_Attachments
    WHERE q_Id = @q_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quote_GetViewById]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Quote_GetViewById]
(
    @q_id INT
)
AS
BEGIN
    SET NOCOUNT ON;
	
	
	SELECT q.[quote_no],q.[quote_date],q.[total_amt],q.[discount],q.[net_amt],q.[increased_rate],q.[t_c]
      ,q.[quote_send],q.[contract_signed],q.[invoiced],q.[payment_received]
	  FROM Quote_Header q
    WHERE q_Id = @q_id;

	SELECT c.[name],c.[description],c.[email],c.[contact_person],c.[mobile_no],c.[addressline1],c.[city],c.[country_subdivision]
      ,c.[country],c.[zip_code]
    from Customer  c
	join Quote_Header q  on c.customer_id=q.customer_id
    WHERE q_Id = @q_id;

    SELECT concat('(',s.code,')',s.name) as ServiceType,concat('(',p.code,')',p.name) as Product,
	concat('(',m.code,')',m.name) as Module,q.license_count,q.rate
			
    FROM Quote_Line q
	join Service_Type s on s.st_id=q.st_id
	join Product p on p.prod_Id=q.pd_id
	join Module m on m.module_id=q.module_id
    WHERE q_id = @q_id;

	SELECT [q_file_id] as id,
		[q_file_id]
      ,[q_id]
      ,[original_name]
      ,[file_name]
      ,[file_path]
    FROM Quote_Attachments
    WHERE q_Id = @q_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quote_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Quote_Update]
(
    @q_id INT,
    @quote_no varchar(50),
    @quote_date date,
    @customer_id int,
	@total_amt decimal(18, 6) ,
	@discount decimal(18, 6) ,
	@net_amt decimal(18, 6) ,
	@increased_rate int ,
	@t_c varchar(MAX) ,
	@quote_send bit ,
	@contract_signed bit ,
	@invoiced bit ,
	@payment_received bit ,
	@updated_by int ,
	@updated_on datetime ,
    @Lines dbo.QuoteLineType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRAN;

    UPDATE Quote_Header
     SET [quote_no] = @quote_no
      ,[quote_date] = @quote_date
      ,[customer_id] = @customer_id
      ,[total_amt] = @total_amt
      ,[discount] = @discount
      ,[net_amt] = @net_amt
      ,[increased_rate] = @increased_rate
      ,[t_c] = @t_c
      ,[quote_send] = @quote_send
      ,[contract_signed] = @contract_signed
      ,[invoiced] = @invoiced
      ,[payment_received] = @payment_received
	,updated_by =@updated_by
	,updated_on =@updated_on
    WHERE q_Id = @q_id;

    DELETE FROM Quote_Line
    WHERE q_id = @q_id;

    
    ;WITH LineCTE AS
(
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS RowNum
    FROM @Lines
)
INSERT INTO Quote_Line
([q_id]
           ,[st_id]
           ,[pd_id]
           ,[module_id]
           ,[rate]
           ,[license_count]
           ,[line_no])
SELECT
    @q_id,
    st_id,
    pd_id,
    module_id,
    rate,
    license_count,
	RowNum
    
FROM LineCTE;
    COMMIT;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RevokeRefreshToken]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RevokeRefreshToken]
    @Token NVARCHAR(500)
AS
BEGIN
    UPDATE RefreshTokens
    SET IsRevoked = 1
    WHERE Token = @Token
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Role_Create]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Role_Create]
    @name NVARCHAR(100),
    @description NVARCHAR(255),
	@CreatedBy int,
    @CreatedOn Datetime,
    @PermissionIds PermissionIdTableType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RoleId INT;

    INSERT INTO Roles (name, description,created_on,created_by)
    VALUES (@name, @description,@CreatedOn,@CreatedBy);

    SET @RoleId = SCOPE_IDENTITY();

    INSERT INTO RolePermissions (role_id, prm_id)
    SELECT @RoleId, PermissionId
    FROM @PermissionIds;

    SELECT @RoleId AS RoleId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Role_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Role_Delete]
    @Id INT
AS
BEGIN
    DELETE FROM RolePermissions WHERE role_id = @Id;
    DELETE FROM Roles WHERE role_id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Role_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Role_GetAll]
AS
BEGIN
    SELECT 
        r.role_id,
        r.name,
        r.description,
        rp.prm_id,
		r.is_active
    FROM Roles r
    LEFT JOIN RolePermissions rp ON r.role_id = rp.role_id
    ORDER BY r.role_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Role_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_Role_Toggle]
(
    @Id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Roles
    WHERE role_id = @Id;

    UPDATE Roles
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
     WHERE role_id = @Id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Role_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Role_Update]
    @role_id INT,
    @name NVARCHAR(100),
    @description NVARCHAR(255),
	@UpdatedBy int,
    @UpdatedOn Datetime,
    @PermissionIds PermissionIdTableType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Roles
    SET name = @name,
        description = @description,
		updated_on=@UpdatedOn,
		updated_by=@UpdatedBy
    WHERE role_id = @role_id;

    DELETE FROM RolePermissions WHERE role_id = @role_id;

    INSERT INTO RolePermissions (role_id,prm_id)
    SELECT @role_id, PermissionId
    FROM @PermissionIds;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveRefreshToken]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveRefreshToken]
    @UserId INT,
    @Token NVARCHAR(500),
    @Expiry DATETIME2
AS
BEGIN
    INSERT INTO RefreshTokens (UserId, Token, ExpiryDate)
    VALUES (@UserId, @Token, @Expiry)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SeedPermissions]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SeedPermissions]
as
BEGIN
    SET NOCOUNT ON;

    DECLARE @MenuName NVARCHAR(100);
    DECLARE @Key NVARCHAR(100);

    DECLARE menu_cursor CURSOR FOR
    SELECT Name FROM Menu where  parent_id IS NOT NULL;

    OPEN menu_cursor;
    FETCH NEXT FROM menu_cursor INTO @MenuName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Create KEY (uppercase + no spaces)
        SET @Key = UPPER(REPLACE(@MenuName, ' ', '_'));

        -- VIEW
        IF NOT EXISTS (SELECT 1 FROM Permissions WHERE Name = CONCAT('VIEW_', @Key))
        BEGIN
            INSERT INTO Permissions (Name, Description, [Key], Label, Created_By)
            VALUES (
                CONCAT('VIEW_', @Key),
                CONCAT('View ', @MenuName),
                @Key,
                @MenuName,
                1
            );
        END

        -- CREATE
        IF NOT EXISTS (SELECT 1 FROM Permissions WHERE Name = CONCAT('CREATE_', @Key))
        BEGIN
            INSERT INTO Permissions (Name, Description, [Key], Label, Created_By)
            VALUES (
                CONCAT('CREATE_', @Key),
                CONCAT('Create ', @MenuName),
                @Key,
                @MenuName,
                1
            );
        END

        -- EDIT
        IF NOT EXISTS (SELECT 1 FROM Permissions WHERE Name = CONCAT('EDIT_', @Key))
        BEGIN
            INSERT INTO Permissions (Name, Description, [Key], Label, Created_By)
            VALUES (
                CONCAT('EDIT_', @Key),
                CONCAT('Edit ', @MenuName),
                @Key,
                @MenuName,
                1
            );
        END

        -- DELETE
        IF NOT EXISTS (SELECT 1 FROM Permissions WHERE Name = CONCAT('DELETE_', @Key))
        BEGIN
            INSERT INTO Permissions (Name, Description, [Key], Label, Created_By)
            VALUES (
                CONCAT('DELETE_', @Key),
                CONCAT('Delete ', @MenuName),
                @Key,
                @MenuName,
                1
            );
        END

        FETCH NEXT FROM menu_cursor INTO @MenuName;
    END

    CLOSE menu_cursor;
    DEALLOCATE menu_cursor;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Service_Type_Delete]
(
    @st_id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE Service_Type
    SET 
        is_deleted = 1
    WHERE st_id = @st_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Service_Type_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Service_Type
	where is_deleted = 0
    ORDER BY st_id asc;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Insert]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_Service_Type_Insert]
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO Service_Type
    (
        code
      ,name
      ,description
      ,created_by
      ,created_on
    )
    VALUES
    (
        @Code,
		@Name,
		@Description,
        @CreatedBy,
        @CreatedOn
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_Service_Type_Toggle]
(
    @st_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Service_Type
    WHERE st_id = @st_id;

    UPDATE Service_Type
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE st_id = @st_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Service_Type_Update]
(
    @st_id int,
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Service_Type
    SET
        name = @name,
        code = @Code,
        description = @Description,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE st_id = @st_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UOM_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UOM_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT uom_id,concat(Code,' (', Name,')') as Code
    FROM UnitOfMeasure 
    ORDER BY uom_id asc;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Create]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_User_Create]
    @Username NVARCHAR(100),
	@FullName NVARCHAR(500),
	@Email NVARCHAR(500),
	@Mobile NVARCHAR(100),
    @Password NVARCHAR(500),
    @Role NVARCHAR(50),
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO Users
    (
        user_name,
		name,
		Email,
		mobile_number,
        Password,
        role_id,
        created_by,
        created_on
    )
    VALUES
    (
        @Username,
		@FullName,
		@Email,
		@Mobile,
        @Password,
        @Role,
        @CreatedBy,
        @CreatedOn
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Delete]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_User_Delete]
    @Id INT
AS
BEGIN
    UPDATE Users
    SET 
        is_deleted = 1
    WHERE user_id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_GetAll]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_GetAll]
AS
BEGIN
    SELECT u.user_id, u.user_name,u.name,u.Email,u.mobile_number, u.role_id,u.is_active,r.name as role
    FROM Users u
	join Roles r on r.role_id=u.role_id
	where u.is_deleted=0 and u.role_id !=1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Toggle]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[sp_User_Toggle]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Users
    WHERE user_id = @id;

    UPDATE Users
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE user_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_User_Update]
    @Id INT,
    @Username NVARCHAR(100),
	@FullName NVARCHAR(500),
	@Email NVARCHAR(500),
	@Mobile NVARCHAR(100),
    @Role NVARCHAR(50),
    @UpdatedBy INT,
	@UpdatedOn Datetime,
	@IsPartialUpdate bit 
AS
BEGIN
 if(@IsPartialUpdate=0)  

    UPDATE Users
    SET 
        user_name = @Username,
		name=@FullName,
		Email=@Email,
		mobile_number=@Mobile,
        role_id = @Role,
        updated_by = @UpdatedBy,
        updated_on = @UpdatedOn
    WHERE user_id = @Id
else
 UPDATE Users
    SET 
        name=@FullName,
		Email=@Email,
		mobile_number=@Mobile,
        updated_by = @UpdatedBy,
        updated_on = @UpdatedOn
    WHERE user_id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[sp_UserPassword_Update]    Script Date: 30-03-2026 16:38:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UserPassword_Update]
    @Id INT,
    @Password NVARCHAR(MAX),
    @UpdatedBy INT,
	@UpdatedOn Datetime
AS
BEGIN
 UPDATE Users
    SET 
        password = @Password,
        updated_by = @UpdatedBy,
        updated_on = @UpdatedOn
    WHERE user_id = @Id

END
GO
USE [master]
GO
ALTER DATABASE [BasicDb] SET  READ_WRITE 
GO
