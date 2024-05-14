/****** Object:  Table [dbo].[Facility]    Script Date: 9-5-2024 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[ACT_DTS] [datetime] NOT NULL,
	[DELIVERY_SQN] [varchar](100) NULL,
	[FacilityID] [varchar](100) NOT NULL,
	[LOAD_DTS] [datetime] NOT NULL,
	[ObligorID] [varchar](100) NULL,
	[ReportingDate] [datetime] NOT NULL,
	[PREV_ACT_DTS] [datetime] NOT NULL,
	[DefaultFlag] [int] NULL,
	[SNPST_DWH_DTS] [datetime] NOT NULL,
	[SSM_CODE] [varchar](50) NULL,
 CONSTRAINT [PK_Facility] PRIMARY KEY CLUSTERED 
(
	[FacilityID] ASC,
	[ReportingDate] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Obligor]    Script Date: 9-5-2024 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Obligor](
	[LOAD_DTS] [datetime] NOT NULL,
	[ObligorID] [varchar](100) NOT NULL,
	[ReportingDate] [date] NOT NULL,
	[ACT_DTS] [datetime] NOT NULL,
	[ObligorGroupID] [nvarchar](100) NULL,
	[ObligorType] [nvarchar](50) NULL,
	[PREV_ACT_DTS] [datetime] NOT NULL,
	[SNPST_DWH_DTS] [datetime] NOT NULL,
	[DELIVERY_SQN] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Obligor] PRIMARY KEY CLUSTERED 
(
	[ObligorID] ASC,
	[ReportingDate] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 9-5-2024 16:19:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[DELIVERY_SQN] [varchar](100) NOT NULL,
	[ReportingDate] [date] NOT NULL,
	[ProductID] [varchar](100) NOT NULL,
	[LOAD_DTS] [datetime] NOT NULL,
	[ObligorID] [varchar](100) NOT NULL,
	[ProductType] [varchar](100) NULL,
	[PartialWriteOffs] [numeric](32, 0) NULL,
	[OffBalanceAmount] [numeric](32, 0) NULL,
	[FacilityID] [varchar](100) NULL,
	[COREPExposureType] [varchar](10) NULL,
	[OnBalanceAmount] [numeric](32, 0) NULL,
	[SpecificProvisions] [numeric](32, 0) NULL,
	[PREV_ACT_DTS] [datetime] NOT NULL,
	[ACT_DTS] [datetime] NOT NULL,
	[CommitmentType] [nvarchar](100) NULL,
	[SNPST_DWH_DTS] [datetime] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ReportingDate] ASC,
	[ProductID] ASC,
	[ObligorID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'554', N'30001', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11001', CAST(N'2019-01-31T00:00:00.000' AS DateTime), CAST(N'2018-12-31T23:59:59.000' AS DateTime), 0, CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'554', N'30002', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11002', CAST(N'2019-01-31T00:00:00.000' AS DateTime), CAST(N'2018-12-31T23:59:59.000' AS DateTime), 0, CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'554', N'30003', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11003', CAST(N'2019-01-31T00:00:00.000' AS DateTime), CAST(N'2018-12-31T23:59:59.000' AS DateTime), 0, CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'555', N'30004', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11004', CAST(N'2019-02-28T00:00:00.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), 0, CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'555', N'30006', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11006', CAST(N'2019-02-28T00:00:00.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), 1, CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'554', N'30007', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11007', CAST(N'2019-01-31T00:00:00.000' AS DateTime), CAST(N'2018-12-31T23:59:59.000' AS DateTime), 1, CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'555', N'30008', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11008', CAST(N'2019-02-28T00:00:00.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), 1, CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'554', N'30009', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11009', CAST(N'2019-01-31T00:00:00.000' AS DateTime), CAST(N'2018-12-31T23:59:59.000' AS DateTime), 1, CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'555', N'30012', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11012', CAST(N'2019-02-28T00:00:00.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), 0, CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'555', N'30013', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11007', CAST(N'2019-02-28T00:00:00.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), 0, CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'CKS')
INSERT [dbo].[Facility] ([ACT_DTS], [DELIVERY_SQN], [FacilityID], [LOAD_DTS], [ObligorID], [ReportingDate], [PREV_ACT_DTS], [DefaultFlag], [SNPST_DWH_DTS], [SSM_CODE]) VALUES (CAST(N'2019-03-31T23:59:59.000' AS DateTime), N'556', N'30022', CAST(N'2023-10-12T16:07:16.000' AS DateTime), N'11022', CAST(N'2019-03-31T00:00:00.000' AS DateTime), CAST(N'2019-02-28T23:59:59.000' AS DateTime), 0, CAST(N'2023-10-12T16:07:16.000' AS DateTime), N'CKS')
GO
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11001', CAST(N'2019-01-31' AS Date), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'11001', N'Natural Person', CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'554')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11002', CAST(N'2019-01-31' AS Date), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'11002', N'Natural Person', CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'554')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11003', CAST(N'2019-01-31' AS Date), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'11003', N'Natural Person', CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'554')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11004', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'11004', N'Natural Person', CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'555')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11006', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'11006', N'Natural Person', CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'555')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11007', CAST(N'2019-01-31' AS Date), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'11007', N'Natural Person', CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'554')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11008', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'11008', N'Natural Person', CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'555')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11009', CAST(N'2019-01-31' AS Date), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'11009', N'Natural Person', CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'554')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11012', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'11012', N'Natural Person', CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'555')
INSERT [dbo].[Obligor] ([LOAD_DTS], [ObligorID], [ReportingDate], [ACT_DTS], [ObligorGroupID], [ObligorType], [PREV_ACT_DTS], [SNPST_DWH_DTS], [DELIVERY_SQN]) VALUES (CAST(N'2023-10-12T16:07:16.000' AS DateTime), N'11022', CAST(N'2019-03-31' AS Date), CAST(N'2019-03-31T23:59:59.000' AS DateTime), N'11022', N'Natural Person', CAST(N'2019-02-28T23:59:59.000' AS DateTime), CAST(N'2023-10-12T16:07:16.000' AS DateTime), N'556')
GO
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'554', CAST(N'2019-01-31' AS Date), N'1205~30001~OBSI', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11001', N'PL', CAST(0 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30001', N'OBSI', CAST(15000 AS Numeric(32, 0)), NULL, CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T15:59:08.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'554', CAST(N'2019-01-31' AS Date), N'1205~30002~OBSI', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11002', N'DK', CAST(0 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30002', N'OBSI', CAST(12057 AS Numeric(32, 0)), NULL, CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T15:59:08.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'554', CAST(N'2019-01-31' AS Date), N'1205~30002~OFBS', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11002', N'DK', CAST(0 AS Numeric(32, 0)), CAST(2942 AS Numeric(32, 0)), N'30002', N'OFBS', CAST(0 AS Numeric(32, 0)), NULL, CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T15:59:08.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'554', CAST(N'2019-01-31' AS Date), N'1205~30003~OFBS', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11003', N'DK', CAST(0 AS Numeric(32, 0)), CAST(12500 AS Numeric(32, 0)), N'30003', N'OFBS', CAST(0 AS Numeric(32, 0)), NULL, CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T15:59:08.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'554', CAST(N'2019-01-31' AS Date), N'1205~30007~OBSI', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11007', N'PL', CAST(1491 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30007', N'OBSI', CAST(0 AS Numeric(32, 0)), NULL, CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T15:59:08.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'554', CAST(N'2019-01-31' AS Date), N'1205~30009~OBSI', CAST(N'2023-10-12T15:59:08.000' AS DateTime), N'11009', N'DK', CAST(480 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30009', N'OBSI', CAST(0 AS Numeric(32, 0)), NULL, CAST(N'2018-12-31T23:59:59.000' AS DateTime), CAST(N'2019-01-31T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T15:59:08.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'555', CAST(N'2019-02-28' AS Date), N'1205~30003~OBSI', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11003', N'DK', CAST(0 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30003', N'OBSI', CAST(1000 AS Numeric(32, 0)), NULL, CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T16:03:15.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'555', CAST(N'2019-02-28' AS Date), N'1205~30004~OBSI', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11004', N'DK', CAST(0 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30004', N'OBSI', CAST(15000 AS Numeric(32, 0)), NULL, CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T16:03:15.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'555', CAST(N'2019-02-28' AS Date), N'1205~30006~OBSI', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11006', N'DK', CAST(0 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30006', N'OBSI', CAST(12057 AS Numeric(32, 0)), NULL, CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T16:03:15.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'555', CAST(N'2019-02-28' AS Date), N'1205~30006~OFBS', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11006', N'DK', CAST(0 AS Numeric(32, 0)), CAST(10442 AS Numeric(32, 0)), N'30006', N'OFBS', CAST(0 AS Numeric(32, 0)), NULL, CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T16:03:15.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'555', CAST(N'2019-02-28' AS Date), N'1205~30008~OBSI', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11008', N'DK', CAST(4500 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30008', N'OBSI', CAST(0 AS Numeric(32, 0)), NULL, CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T16:03:15.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'555', CAST(N'2019-02-28' AS Date), N'1205~30012~OBSI', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11012', N'PL', CAST(4950 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30012', N'OBSI', CAST(0 AS Numeric(32, 0)), NULL, CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T16:03:15.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'555', CAST(N'2019-02-28' AS Date), N'1205~30013~OBSI', CAST(N'2023-10-12T16:03:15.000' AS DateTime), N'11007', N'PL', CAST(0 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30013', N'OBSI', CAST(7500 AS Numeric(32, 0)), NULL, CAST(N'2019-01-31T23:59:59.000' AS DateTime), CAST(N'2019-02-28T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T16:03:15.000' AS DateTime))
INSERT [dbo].[Product] ([DELIVERY_SQN], [ReportingDate], [ProductID], [LOAD_DTS], [ObligorID], [ProductType], [PartialWriteOffs], [OffBalanceAmount], [FacilityID], [COREPExposureType], [OnBalanceAmount], [SpecificProvisions], [PREV_ACT_DTS], [ACT_DTS], [CommitmentType], [SNPST_DWH_DTS]) VALUES (N'556', CAST(N'2019-03-31' AS Date), N'1205~30022~OBSI', CAST(N'2023-10-12T16:07:16.000' AS DateTime), N'11022', N'PL', CAST(0 AS Numeric(32, 0)), CAST(0 AS Numeric(32, 0)), N'30022', N'OBSI', CAST(100 AS Numeric(32, 0)), NULL, CAST(N'2019-02-28T23:59:59.000' AS DateTime), CAST(N'2019-03-31T23:59:59.000' AS DateTime), N'Committed', CAST(N'2023-10-12T16:07:16.000' AS DateTime))
GO
ALTER TABLE [dbo].[Obligor] ADD  DEFAULT ('0') FOR [DELIVERY_SQN]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ('0') FOR [DELIVERY_SQN]
GO
