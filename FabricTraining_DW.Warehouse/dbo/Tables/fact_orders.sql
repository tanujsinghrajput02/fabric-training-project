CREATE TABLE [dbo].[fact_orders] (

	[order_id] int NOT NULL, 
	[customer_id] int NULL, 
	[product_id] int NULL, 
	[order_date] date NULL, 
	[quantity] int NULL, 
	[total_amount] decimal(18,2) NULL
);


GO
ALTER TABLE [dbo].[fact_orders] ADD CONSTRAINT PK_fact_orders primary key NONCLUSTERED ([order_id]);
GO
ALTER TABLE [dbo].[fact_orders] ADD CONSTRAINT FK_fact_customer FOREIGN KEY ([customer_id]) REFERENCES [dbo].[dim_customer]([customer_id]);
GO
ALTER TABLE [dbo].[fact_orders] ADD CONSTRAINT FK_fact_product FOREIGN KEY ([product_id]) REFERENCES [dbo].[dim_product]([product_id]);