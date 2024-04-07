-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).
-- I will be applying Normalization on the orders table,
-- I will reduce reduncies and make the data more efficient

SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [orders] (
    [row_id] int  NOT NULL ,
    [order_id] varchar(20)  NOT NULL ,
    [created_at] datetime  NOT NULL ,
    [item_id] varchar(10)  NOT NULL ,
    [quantity] int  NOT NULL ,
    [cust_id] int  NOT NULL ,
    [delivery] boolean  NOT NULL ,
    [address_id] int  NOT NULL ,
    CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

-- a new customer table will be created with a pk
-- Order table will only contain customer pk
CREATE TABLE [customers] (
    [cust_id] int  NOT NULL ,
    [cust_firstName] varchar(50)  NOT NULL ,
    [cust_lastName] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED (
        [cust_id] ASC
    )
)

-- a new address table will be created with a pk
-- order talbe will only contain address pk
CREATE TABLE [address] (
    [address_id] int  NOT NULL ,
    [delivery_address1] varchar(200)  NULL ,
    [delivery_address2] varchar(200)  NULL ,
    [delivery_city] varchar(50)  NOT NULL ,
    [delivery_zipCode] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED (
        [address_id] ASC
    )
)

-- a new items table will be created with a pk
-- order talbe will only contain item pk
CREATE TABLE [item] (
    [item_id] varchar(10)  NOT NULL ,
    [skku] varchar(20)  NOT NULL ,
    [item_name] varchar(100)  NOT NULL ,
    [item_category] varchar(100)  NOT NULL ,
    [item_size] varchar(20)  NOT NULL ,
    [item_price] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_item] PRIMARY KEY CLUSTERED (
        [item_id] ASC
    )
)

ALTER TABLE [customers] WITH CHECK ADD CONSTRAINT [FK_customers_cust_id] FOREIGN KEY([cust_id])
REFERENCES [orders] ([cust_id])

ALTER TABLE [customers] CHECK CONSTRAINT [FK_customers_cust_id]

ALTER TABLE [address] WITH CHECK ADD CONSTRAINT [FK_address_address_id] FOREIGN KEY([address_id])
REFERENCES [orders] ([address_id])

ALTER TABLE [address] CHECK CONSTRAINT [FK_address_address_id]

ALTER TABLE [item] WITH CHECK ADD CONSTRAINT [FK_item_item_id] FOREIGN KEY([item_id])
REFERENCES [orders] ([item_id])

ALTER TABLE [item] CHECK CONSTRAINT [FK_item_item_id]

COMMIT TRANSACTION QUICKDBD