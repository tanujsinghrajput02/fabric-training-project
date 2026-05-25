CREATE TABLE [dbo].[dim_customer] (

	[customer_id] int NOT NULL, 
	[name] varchar(100) NULL, 
	[region] varchar(50) NULL, 
	[signup_date] date NULL
);


GO
ALTER TABLE [dbo].[dim_customer] ADD CONSTRAINT PK_dim_customer primary key NONCLUSTERED ([customer_id]);