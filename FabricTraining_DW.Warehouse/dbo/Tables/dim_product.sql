CREATE TABLE [dbo].[dim_product] (

	[product_id] int NOT NULL, 
	[product_name] varchar(100) NULL, 
	[category] varchar(50) NULL, 
	[unit_price] decimal(10,2) NULL
);


GO
ALTER TABLE [dbo].[dim_product] ADD CONSTRAINT PK_dim_product primary key NONCLUSTERED ([product_id]);