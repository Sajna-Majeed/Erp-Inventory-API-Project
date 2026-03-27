USE [BasicDb]
GO
/****** Object:  UserDefinedTableType [dbo].[AttachmentType]    Script Date: 27-03-2026 11:38:02 ******/
CREATE TYPE [dbo].[AttachmentType] AS TABLE(
	[Original_Name] [nvarchar](255) NULL,
	[File_Name] [nvarchar](255) NULL,
	[File_Path] [nvarchar](500) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[IntListType]    Script Date: 27-03-2026 11:38:02 ******/
CREATE TYPE [dbo].[IntListType] AS TABLE(
	[Id] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[InvoiceLineType]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  UserDefinedTableType [dbo].[PermissionIdTableType]    Script Date: 27-03-2026 11:38:02 ******/
CREATE TYPE [dbo].[PermissionIdTableType] AS TABLE(
	[PermissionId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[QuoteLineType]    Script Date: 27-03-2026 11:38:02 ******/
CREATE TYPE [dbo].[QuoteLineType] AS TABLE(
	[st_id] [int] NULL,
	[pd_id] [int] NULL,
	[module_id] [int] NULL,
	[rate] [decimal](18, 3) NULL,
	[license_count] [int] NULL
)
GO
/****** Object:  Table [dbo].[AppLogs]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[BussinessPartner]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Company]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Custom_Price]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Custom_Price](
	[custom_prod_id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NULL,
	[customer_id] [int] NULL,
	[st_id] [int] NULL,
	[pd_id] [int] NULL,
	[module_id] [int] NULL,
	[unit_price] [decimal](18, 3) NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_Custome_Price] PRIMARY KEY CLUSTERED 
(
	[custom_prod_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Customer_Service]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Service](
	[cus_srv_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[pd_id] [int] NULL,
	[module_id] [int] NULL,
	[license_count] [int] NULL,
	[notes] [text] NULL,
	[created_by] [int] NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NOT NULL,
	[is_active] [nchar](10) NULL,
	[last_billed_date] [datetime] NULL,
	[expiary_date] [datetime] NULL,
 CONSTRAINT [PK_Customer_Service] PRIMARY KEY CLUSTERED 
(
	[cus_srv_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_Type]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[CustomMenu]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[ErrorLogs]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Module]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Permissions]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[prod_Id] [int] IDENTITY(1,1) NOT NULL,
	[code] [varchar](10) NULL,
	[name] [varchar](30) NULL,
	[description] [varchar](max) NULL,
	[st_Id] [int] NULL,
	[unit_price] [decimal](18, 3) NULL,
	[created_by] [int] NULL,
	[created_on] [datetime] NULL,
	[updated_by] [int] NULL,
	[updated_on] [datetime] NULL,
	[is_deleted] [bit] NULL,
	[is_active] [bit] NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[prod_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quote_Attachments]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Quote_Header]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quote_Header](
	[q_id] [int] IDENTITY(1,1) NOT NULL,
	[quote_no] [varchar](20) NULL,
	[quote_date] [date] NULL,
	[customer_id] [int] NULL,
	[total_amt] [decimal](18, 6) NULL,
	[discount] [decimal](18, 6) NULL,
	[net_amt] [decimal](18, 6) NULL,
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
/****** Object:  Table [dbo].[Quote_Line]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[RolePermissions]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Service_Type]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[UnitOfMeasure]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 27-03-2026 11:38:02 ******/
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
ALTER TABLE [dbo].[Custom_Price] ADD  CONSTRAINT [DF_Custome_Price_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Custom_Price] ADD  CONSTRAINT [DF_Custome_Price_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Customer_Service] ADD  CONSTRAINT [DF_Customer_Service_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Customer_Type] ADD  CONSTRAINT [DF_Customer_type_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Customer_Type] ADD  CONSTRAINT [DF_Customer_type_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  DEFAULT (getutcdate()) FOR [TimeStamp]
GO
ALTER TABLE [dbo].[Menu] ADD  CONSTRAINT [DF_Menu_display_order]  DEFAULT ((0)) FOR [display_order]
GO
ALTER TABLE [dbo].[Module] ADD  CONSTRAINT [DF_Module_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Module] ADD  CONSTRAINT [DF_Module_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF__Permissio__creat__02925FBF]  DEFAULT (getdate()) FOR [created_on]
GO
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF__Permissio__is_de__038683F8]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_code]  DEFAULT ('') FOR [code]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_product_is_deleted]  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_is_active]  DEFAULT ((1)) FOR [is_active]
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
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_Insert]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BussinessPartner_Insert]
(
	@code varchar(10),
	@customer_type_id int,
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
		code,
		customer_type_id,
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
		@code,
		@customer_type_id,
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
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_BussinessPartner_Update]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_BussinessPartner_Update]
(
    @bp_id int,
	@code varchar(10),
	@customer_type_id int,
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
		code=@code,
		customer_type_id=@customer_type_id,
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
/****** Object:  StoredProcedure [dbo].[sp_Company_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Company_Menu]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Custom_Price_Delete]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Custom_Price_Delete]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;
	UPDATE Custom_Price
    SET 
        is_deleted = 1
    WHERE custom_prod_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Custom_Price_Filtered]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Custom_Price_Filtered]
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
/****** Object:  StoredProcedure [dbo].[sp_Custom_Price_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Custom_Price_GetAll]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT c.code,c.custom_prod_id,c.st_id,c.pd_id,c.module_id,c.unit_price,c.customer_id,c.is_active,
	s.Name as ServiceType, p.Name as Product, m.name as Module,b.name as Customer
    FROM Custom_Price c
	join Service_Type s on s.st_id=c.st_id
	join Customer b on b.customer_id=c.customer_id
	join Product p on p.prod_Id=c.pd_id
	join Module m on m.module_id=c.module_id
	where c.is_deleted = 0
    ORDER BY c.custom_prod_id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Custom_Price_GetById]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Custom_Price_GetById]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Custom_Price
    WHERE custom_prod_id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Custom_Price_Insert]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Custom_Price_Insert]
(
	@code varchar(10),
	@customer_id int,
	@st_id int,
	@pd_id int,
	@module_id int,
	@unit_price decimal(18,3),
	@CreatedBy int,
    @CreatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Custom_Price
    (	code,
        customer_id,
		st_id,
		pd_id,
        module_id,
        unit_price,
		created_by,
		created_on
    )
    VALUES
    (	@code,
        @customer_id,
		@st_id,
		@pd_id,
        @module_id,
        @unit_price,
		@CreatedBy,
		@CreatedOn
    );

    SELECT SCOPE_IDENTITY() AS custom_prod_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Custom_Price_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[sp_Custom_Price_Toggle]
(
    @id int
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @status BIT;

    SELECT @status = is_active
    FROM Custom_Price
     WHERE custom_prod_id = @id;

    UPDATE Custom_Price
    SET is_active = CASE 
                        WHEN @status = 1 THEN 0
                        ELSE 1
                    END
     WHERE custom_prod_id = @id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Custom_Price_Update]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Custom_Price_Update]
(	
	@code varchar(10),
    @custom_prod_id int,
	@customer_id int,
	@st_id int,
	@pd_id int,
	@module_id int,
	@unit_price decimal(18,3),
	@UpdatedBy INT,
	@UpdatedOn Datetime
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Custom_Price
    SET
       customer_id=@customer_id,
	   code=@code,
	   st_id=@st_id,
	   pd_id=@pd_id,
	   module_id=@module_id,
	   unit_price=@unit_price,
	   updated_by=@UpdatedBy,
		updated_on=@UpdatedOn
    WHERE custom_prod_id = @custom_prod_id;

    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
    ORDER BY customer_id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Customer_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Insert]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Insert]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Type_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Customer_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetRefreshToken]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Invoice_Create]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Invoice_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Invoice_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Invoice_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Invoice_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Module_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Module_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Module_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Module_GetByProductId]    Script Date: 27-03-2026 11:38:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_Module_GetByProductId]
(
    @pd_id int
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Module
    WHERE product_id = @pd_id and is_deleted=0;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Module_Insert]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Module_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Module_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Product_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Product_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Product_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Product_Insert]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Product_Search]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Product_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Product_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quote_Attachments_Save]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quote_Create]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quote_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quote_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quote_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quote_GetViewById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quote_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RevokeRefreshToken]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Role_Create]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Role_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Role_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Role_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Role_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveRefreshToken]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SeedPermissions]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_GetById]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Insert]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Service_Type_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UOM_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_User_Create]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_User_Delete]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_User_GetAll]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_User_Toggle]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_User_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UserPassword_Update]    Script Date: 27-03-2026 11:38:02 ******/
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
