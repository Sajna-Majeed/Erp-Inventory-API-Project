USE [master]
GO
/****** Object:  Database [BasicDb]    Script Date: 05-03-2026 17:34:25 ******/
CREATE DATABASE [BasicDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BasicDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BasicDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
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
/****** Object:  UserDefinedTableType [dbo].[InvoiceLineType]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  Table [dbo].[BussinessPartner]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BussinessPartner](
	[bp_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[email] [varchar](150) NULL,
	[contact_person] [varchar](50) NULL,
	[mobile_no] [varchar](10) NULL,
	[addressline1] [varchar](150) NULL,
	[city] [varchar](50) NULL,
	[country] [varchar](50) NULL,
	[country_subdivision] [varchar](50) NULL,
	[e_identifier] [varchar](15) NULL,
	[legal_reg_identifier] [varchar](15) NULL,
	[legal_reg_type] [varchar](30) NULL,
	[tax_identifier] [varchar](30) NULL,
	[tax_scheme_code] [varchar](10) NULL,
	[is_customer] [bit] NOT NULL,
	[is_seller] [bit] NOT NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED 
(
	[bp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  Table [dbo].[Customer_Type]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Type](
	[ct_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[description] [varchar](max) NOT NULL,
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
/****** Object:  Table [dbo].[Invoice_Header]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Header](
	[invoice_Id] [int] IDENTITY(1,1) NOT NULL,
	[invoice_no] [varchar](20) NULL,
	[invoice_date] [date] NULL,
	[invoice_type_code] [varchar](20) NULL,
	[invoice_curreny_code] [varchar](5) NULL,
	[invoice_tsn_code] [varchar](10) NULL,
	[due_date] [date] NULL,
	[bsn_process_type] [varchar](10) NULL,
	[specification_identifier] [varchar](50) NULL,
	[payment_means_type_code] [varchar](10) NULL,
	[net_amt] [decimal](18, 3) NULL,
	[total_wo_tax] [decimal](18, 3) NULL,
	[total_tax_amt] [decimal](18, 3) NULL,
	[total_w_tax] [decimal](18, 3) NULL,
	[payment_due_amt] [decimal](18, 3) NULL,
	[tax_cat_taxable_amt] [decimal](18, 3) NULL,
	[tax_cat_tax_amt] [decimal](18, 3) NULL,
	[tax_cat_code] [varchar](10) NULL,
	[tax_cat_rate] [decimal](18, 3) NULL,
	[bp_Id] [int] NULL,
	[addressline] [varchar](max) NULL,
	[created_by] [int] NULL,
	[created_on] [datetime] NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Invoice_Header] PRIMARY KEY CLUSTERED 
(
	[invoice_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice_Line]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Line](
	[invoice_line_id] [int] IDENTITY(1,1) NOT NULL,
	[invoice_id] [int] NOT NULL,
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
	[amt_in_aed] [decimal](18, 6) NULL,
	[line_no] [int] NOT NULL,
 CONSTRAINT [PK_Invoice_Line] PRIMARY KEY CLUSTERED 
(
	[invoice_line_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Module]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Module](
	[module_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NOT NULL,
	[name] [varchar](20) NOT NULL,
	[description] [varchar](max) NULL,
	[product_id] [int] NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
 CONSTRAINT [PK_Module] PRIMARY KEY CLUSTERED 
(
	[module_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[prod_Id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NULL,
	[name] [varchar](30) NULL,
	[description] [varchar](max) NULL,
	[uom_id] [int] NULL,
	[unit_price] [decimal](18, 3) NULL,
	[tax_rate] [decimal](18, 3) NULL,
	[created_by] [int] NULL,
	[created_on] [datetime] NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[prod_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  Table [dbo].[Service_Type]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  Table [dbo].[UnitOfMeasure]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](150) NULL,
	[Email] [nvarchar](150) NULL,
	[MobileNumber] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [text] NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[updatedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[BussinessPartner] ADD  CONSTRAINT [DF_Seller_is_customer]  DEFAULT ((0)) FOR [is_customer]
GO
ALTER TABLE [dbo].[BussinessPartner] ADD  CONSTRAINT [DF_Seller_is_seller]  DEFAULT ((0)) FOR [is_seller]
GO
ALTER TABLE [dbo].[BussinessPartner] ADD  CONSTRAINT [DF_BussinessPartner_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[BussinessPartner] ADD  CONSTRAINT [DF_BussinessPartner_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_name]  DEFAULT ('') FOR [name]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Customer_Type] ADD  CONSTRAINT [DF_Customer_type_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Customer_Type] ADD  CONSTRAINT [DF_Customer_type_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Invoice_Header] ADD  CONSTRAINT [DF_Invoice_Header_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Invoice_Line] ADD  CONSTRAINT [DF__Invoice_L__line___29221CFB]  DEFAULT ((1)) FOR [line_no]
GO
ALTER TABLE [dbo].[Module] ADD  CONSTRAINT [DF_Module_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Module] ADD  CONSTRAINT [DF_Module_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_code]  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_product_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[RefreshTokens] ADD  DEFAULT ((0)) FOR [IsRevoked]
GO
ALTER TABLE [dbo].[Service_Type] ADD  CONSTRAINT [DF_Service_Type_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Service_Type] ADD  CONSTRAINT [DF_Service_Type_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[UnitOfMeasure] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UnitOfMeasure] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__IsDeleted__4D94879B]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_Delete]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BussinessPartner_Delete]
(
    @bp_id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE BussinessPartner
    SET 
        is_deleted = 1
    WHERE bp_id = @bp_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_GetAll]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BussinessPartner_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM BussinessPartner
	where is_deleted = 0
    ORDER BY bp_id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_GetById]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BussinessPartner_GetById]
(
    @bp_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM BussinessPartner
    WHERE bp_id = @bp_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_Insert]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BussinessPartner_Insert]
(
    @name varchar(50),
    @contact_person varchar(50),
    @email varchar(150),
    @mobile_Number varchar(10),
    @e_identifier varchar(15),
    @legal_reg_identifier varchar(15),
    @legal_reg_type varchar(30),
    @tax_identifier varchar(30),
    @tax_scheme_code varchar(10),
    @addressline1 varchar(50),
    @city varchar(50),
    @country_subdivision varchar(50),
    @country varchar(50),
    @is_customer bit,
    @is_seller bit,
	@CreatedBy int,
    @CreatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO BussinessPartner
    (
        name,
        contact_person,
        email,
        mobile_no,
        e_identifier,
        legal_reg_identifier,
        legal_reg_type,
        tax_identifier,
        tax_scheme_code,
        addressline1,
        city,
        country_subdivision,
        country,
        is_customer,
        is_seller,
		created_by,
		created_on
    )
    VALUES
    (
        @name,
        @contact_person,
        @email,
        @mobile_Number,
        @e_identifier,
        @legal_reg_identifier,
        @legal_reg_type,
        @tax_identifier,
        @tax_scheme_code,
        @addressline1,
        @city,
        @country_subdivision,
        @country,
        @is_customer,
        @is_seller,
		@CreatedBy,
		@CreatedOn
    );

    SELECT SCOPE_IDENTITY() AS bp_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_Toggle]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_BussinessPartner_Toggle]
(
    @bp_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM BussinessPartner
     WHERE bp_id = @bp_id;

    UPDATE BussinessPartner
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
     WHERE bp_id = @bp_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_Update]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BussinessPartner_Update]
(
    @bp_id int,
    @name varchar(50),
    @contact_person varchar(50),
    @email varchar(150),
    @mobile_number varchar(10),
    @e_identifier varchar(15),
    @legal_reg_identifier varchar(15),
    @legal_reg_type varchar(30),
    @tax_identifier varchar(30),
    @tax_scheme_code varchar(10),
    @addressline1 varchar(50),
    @city varchar(50),
    @country_subdivision varchar(50),
    @country varchar(50),
    @is_customer tinyint,
    @is_seller tinyint,
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE BussinessPartner
    SET
        name = @name,
        contact_person = @contact_person,
        email = @email,
        mobile_no = @mobile_number,
        e_identifier = @e_identifier,
        legal_reg_identifier = @legal_reg_identifier,
        legal_reg_type = @legal_reg_type,
        tax_identifier = @tax_identifier,
        tax_scheme_code = @tax_scheme_code,
        addressline1 = @addressline1,
        city = @city,
        country_subdivision = @country_subdivision,
        country = @country,
        is_customer = @is_customer,
        is_seller = @is_seller,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE bp_id = @bp_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Company_GetById]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Delete]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_GetAll]    Script Date: 05-03-2026 17:34:25 ******/
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
    ORDER BY ct_id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_GetById]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Insert]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Toggle]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Update]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetRefreshToken]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Invoice_Create]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Invoice_Create]
(
    @invoice_no varchar(50),
    @invoice_date date,
    @invoice_type_code varchar(10),
    @invoice_curreny_code varchar(5),
    @invoice_tsn_code varchar(10),
    @due_date date,
    @bsn_process_type varchar(10),
    @specification_identifier varchar(50),
    @payment_means_type_code nchar(10),
    @net_amt decimal(18,6),
    @total_wo_tax decimal(18,6),
    @total_tax_amt decimal(18,6),
    @total_w_tax decimal(18,6),
    @payment_due_amt decimal(18,6),
    @tax_cat_taxable_amt decimal(18,6),
    @tax_cat_tax_amt decimal(18,6),
    @tax_cat_code varchar(10),
    @tax_cat_rate decimal(18,6),
	@address_line varchar(MAX),
	@bp_id int,
	@created_by int,
    @created_on datetime,
    @Lines dbo.InvoiceLineType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRAN;

    INSERT INTO Invoice_Header
    (
        invoice_no, invoice_date, invoice_type_code, invoice_curreny_code,
        invoice_tsn_code, due_date, bsn_process_type, specification_identifier,
        payment_means_type_code, net_amt, total_wo_tax, total_tax_amt,
        total_w_tax, payment_due_amt, tax_cat_taxable_amt,
        tax_cat_tax_amt, tax_cat_code, tax_cat_rate,bp_Id,addressline,created_by,created_on
    )
    VALUES
    (
        @invoice_no, @invoice_date, @invoice_type_code, @invoice_curreny_code,
        @invoice_tsn_code, @due_date, @bsn_process_type, @specification_identifier,
        @payment_means_type_code, @net_amt, @total_wo_tax, @total_tax_amt,
        @total_w_tax, @payment_due_amt, @tax_cat_taxable_amt,
        @tax_cat_tax_amt, @tax_cat_code, @tax_cat_rate,@bp_id,@address_line,@created_by,@created_on
    );

    DECLARE @InvoiceId INT = SCOPE_IDENTITY();

	;WITH LineCTE AS
(
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS RowNum
    FROM @Lines
)
INSERT INTO Invoice_Line
(
    invoice_id,
    line_no,
    item_name,
    description,
    inv_line_identifier,
    unit_of_measure_code,
    net_amt,
    item_net_price,
    item_gross_price,
    item_price_base_qty,
    item_tax_cat_code,
    item_tax_rate,
    vat_in_aed,
    amt_in_aed
)
SELECT
    @InvoiceId,
    RowNum,
    item_name,
    description,
    inv_line_identifier,
    unit_of_measure_code,
    net_amt,
    item_net_price,
    item_gross_price,
    item_price_base_qty,
    item_tax_cat_code,
    item_tax_rate,
    vat_in_aed,
    amt_in_aed
FROM LineCTE;
    COMMIT;

    SELECT @InvoiceId AS invoice_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Invoice_Delete]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Invoice_Delete]
(
    @invoice_id INT
)
AS
BEGIN
    BEGIN TRAN;

    DELETE FROM Invoice_Line
    WHERE invoice_id = @invoice_id;

    Update  Invoice_Header Set is_deleted=1
    WHERE invoice_id = @invoice_id;

    COMMIT;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Invoice_GetAll]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Invoice_GetAll]
AS
BEGIN
 SELECT [invoice_Id]
      ,[invoice_no]
      ,[invoice_date]
      ,[due_date]
      ,[total_w_tax] as total,'Pending' as status
	  ,b.name as partner
  FROM [BasicDb].[dbo].[Invoice_Header] i join BussinessPartner b on b.bp_id=i.bp_Id where i.is_deleted=0
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Invoice_GetById]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Invoice_GetById]
(
    @invoice_id INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * 
    FROM Invoice_Header
    WHERE invoice_Id = @invoice_id;

    SELECT *
    FROM Invoice_Line
    WHERE invoice_id = @invoice_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Invoice_Update]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Invoice_Update]
(
    @invoice_id INT,

    @invoice_no varchar(50),
    @invoice_date date,
    @invoice_type_code varchar(10),
    @invoice_curreny_code varchar(5),
    @invoice_tsn_code varchar(10),
    @due_date date,
    @bsn_process_type varchar(10),
    @specification_identifier varchar(50),
    @payment_means_type_code nchar(10),
    @net_amt decimal(18,6),
    @total_wo_tax decimal(18,6),
    @total_tax_amt decimal(18,6),
    @total_w_tax decimal(18,6),
    @payment_due_amt decimal(18,6),
    @tax_cat_taxable_amt decimal(18,6),
    @tax_cat_tax_amt decimal(18,6),
    @tax_cat_code varchar(10),
    @tax_cat_rate decimal(18,6),
	@address_line varchar(MAX),
	@bp_id int,
	@updated_by int,
    @updated_on datetime,
    @Lines dbo.InvoiceLineType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRAN;

    UPDATE Invoice_Header
    SET
        invoice_no = @invoice_no,
        invoice_date = @invoice_date,
        invoice_type_code = @invoice_type_code,
        invoice_curreny_code = @invoice_curreny_code,
        invoice_tsn_code = @invoice_tsn_code,
        due_date = @due_date,
        bsn_process_type = @bsn_process_type,
        specification_identifier = @specification_identifier,
        payment_means_type_code = @payment_means_type_code,
        net_amt = @net_amt,
        total_wo_tax = @total_wo_tax,
        total_tax_amt = @total_tax_amt,
        total_w_tax = @total_w_tax,
        payment_due_amt = @payment_due_amt,
        tax_cat_taxable_amt = @tax_cat_taxable_amt,
        tax_cat_tax_amt = @tax_cat_tax_amt,
        tax_cat_code = @tax_cat_code,
        tax_cat_rate = @tax_cat_rate,
		bp_Id=@bp_id,
		addressline=@address_line,
		updated_by =@updated_by,
		updated_on =@updated_on
    WHERE invoice_Id = @invoice_id;

    DELETE FROM Invoice_Line
    WHERE invoice_id = @invoice_id;

    
    ;WITH LineCTE AS
(
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS RowNum
    FROM @Lines
)
INSERT INTO Invoice_Line
(
    invoice_id,
    line_no,
    item_name,
    description,
    inv_line_identifier,
    unit_of_measure_code,
    net_amt,
    item_net_price,
    item_gross_price,
    item_price_base_qty,
    item_tax_cat_code,
    item_tax_rate,
    vat_in_aed,
    amt_in_aed
)
SELECT
   @invoice_id,
    RowNum,
    item_name,
    description,
    inv_line_identifier,
    unit_of_measure_code,
    net_amt,
    item_net_price,
    item_gross_price,
    item_price_base_qty,
    item_tax_cat_code,
    item_tax_rate,
    vat_in_aed,
    amt_in_aed
FROM LineCTE;
    COMMIT;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Module_Delete]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Module_Delete]
(
    @module_id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE Module
    SET 
        is_deleted = 1
    WHERE module_id = @module_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Module_GetAll]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Module_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Module
	where is_deleted = 0
    ORDER BY module_id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Module_GetById]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Module_GetById]
(
    @module_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Module
    WHERE module_id = @module_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Module_Insert]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_Module_Insert]
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@Product_Id int,
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO Module
    (
        code
      ,name
      ,description
	  ,product_id
      ,created_by
      ,created_on
    )
    VALUES
    (
        @Code,
		@Name,
		@Description,
		@Product_Id,
        @CreatedBy,
        @CreatedOn
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Module_Toggle]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_Module_Toggle]
(
    @module_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Module
    WHERE module_id = @module_id;

    UPDATE Module
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE module_id = @module_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Module_Update]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Module_Update]
(
    @module_id int,
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@Product_Id int,
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Module
    SET
        name = @name,
        code = @Code,
		product_id=@Product_Id,
        description = @Description,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE module_id = @module_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Delete]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Product_Delete]
(
    @prod_id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE Product
    SET 
        is_deleted = 1
    WHERE prod_Id = @prod_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_GetAll]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Product_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Product
	where is_deleted = 0
    ORDER BY prod_id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_GetById]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Product_GetById]
(
    @prod_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Product
    WHERE prod_Id = @prod_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Insert]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Product_Insert]
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@Uom_Id INT,
    @Unit_Price decimal(18,3),
    @Tax_rate decimal(18,3),
    @CreatedBy int,
    @CreatedOn Datetime
AS
BEGIN
    INSERT INTO Product
    (
        code
      ,name
      ,description
      ,uom_id
      ,unit_price
      ,tax_rate
      ,created_by
      ,created_on
    )
    VALUES
    (
        @Code,
		@Name,
		@Description,
		@Uom_Id,
        @Unit_Price,
        @Tax_rate,
        @CreatedBy,
        @CreatedOn
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Search]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Product_Search]
    @SearchTerm NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 20
        prod_Id,
        code,
        Name,
        Description,
        Uom,
        unit_price,
        tax_rate
    FROM Product
    WHERE is_deleted = 0
      AND (
            code LIKE '%' + @SearchTerm + '%'
            OR Name LIKE '%' + @SearchTerm + '%'
          )
    ORDER BY Name ASC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Toggle]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_Product_Toggle]
(
    @prod_Id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Product
    WHERE prod_Id = @prod_Id;

    UPDATE Product
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
    WHERE prod_Id = @prod_Id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Product_Update]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Product_Update]
(
    @prod_id int,
    @Code VARCHAR(10),
	@Name VARCHAR(30),
	@Description VARCHAR(500),
	@Uom_Id VARCHAR(10),
    @Unit_Price decimal(18,3),
    @Tax_rate decimal(18,3),
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Product
    SET
        name = @name,
        code = @Code,
        description = @Description,
        uom_id = @Uom_Id,
        unit_price = @Unit_Price,
        tax_rate = @Tax_rate,
		updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE prod_Id = @prod_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RevokeRefreshToken]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveRefreshToken]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Delete]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_GetAll]    Script Date: 05-03-2026 17:34:25 ******/
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
    ORDER BY st_id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_GetById]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Service_Type_GetById]
(
    @st_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Service_Type
    WHERE st_id = @st_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Insert]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Toggle]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Update]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UOM_GetAll]    Script Date: 05-03-2026 17:34:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_User_Create]    Script Date: 05-03-2026 17:34:25 ******/
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
        Username,
		FullName,
		Email,
		MobileNumber,
        Password,
        Role,
        CreatedBy,
        CreatedOn,
		IsDeleted
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
        @CreatedOn,
		0
    );

    SELECT SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Delete]    Script Date: 05-03-2026 17:34:25 ******/
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
        IsDeleted = 1
    WHERE UserId = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_GetAll]    Script Date: 05-03-2026 17:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_User_GetAll]
AS
BEGIN
    SELECT UserId, Username,FullName,Email,MobileNumber, Role, CreatedOn
    FROM Users where IsDeleted=0 and Role='User'
END
GO
/****** Object:  StoredProcedure [dbo].[sp_User_Update]    Script Date: 05-03-2026 17:34:25 ******/
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
	@UpdatedOn Datetime
AS
BEGIN
    UPDATE Users
    SET 
        Username = @Username,
		FullName=@FullName,
		Email=@Email,
		MobileNumber=@Mobile,
        Role = @Role,
        UpdatedBy = @UpdatedBy,
        UpdatedOn = @UpdatedOn
    WHERE UserId = @Id
END
GO
USE [master]
GO
ALTER DATABASE [BasicDb] SET  READ_WRITE 
GO
