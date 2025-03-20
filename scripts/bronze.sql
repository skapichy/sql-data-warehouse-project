/*
DDL: Scripts bronze tables
This scripts creates table in the bronze schema

*/

--- Using of 'Bulk insert' to insert multiple rows at once into the database engine
BULK INSERT bronze.crm_cust_info
FROM 'C:\\Users\\Micheal\\Downloads\\sql-data-warehouse-project\\sql-data-warehouse-project\\datasets\\source_crm\\cust_info.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
-- select top 20 of the dataset
SELECT top (20)* FROM bronze.crm_cust_info bc

BULK INSERT bronze.crm_prd_info
FROM 'C:\\Users\\Micheal\\Downloads\\sql-data-warehouse-project\\sql-data-warehouse-project\\datasets\\source_crm\\prd_info.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);


BULK INSERT bronze.crm_sales_details
FROM 'C:\\Users\\Micheal\\Downloads\\sql-data-warehouse-project\\sql-data-warehouse-project\\datasets\\source_crm\\sales_details.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

BULK INSERT bronze.erp_loc_A101
FROM 'C:\\Users\\Micheal\\Downloads\\sql-data-warehouse-project\\sql-data-warehouse-project\\datasets\\source_erp\\loc_A101.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
); 

CREATE TABLE bronze_erp_px_cat_G1V2(
	id INT,
	category NVARCHAR(50),
	subcategory NVARCHAR(50),
	Maintenance NVARCHAR(50)
);

BULK INSERT erp_px_cat_G1V2
FROM 'C:\\Users\\Micheal\\Downloads\\sql-data-warehouse-project\\sql-data-warehouse-project\\datasets\\source_erp\\px_cat_G1V2.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

BULK INSERT [WarehouseDB].dbo.erp_cust
FROM 'C:\\Users\\Micheal\\Downloads\\sql-data-warehouse-project\\sql-data-warehouse-project\\datasets\\source_erp\\CUST_AZ12.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',  -- Safer for line endings
    TABLOCK
);

--- check if the table_name and schema exists
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'erp_cust_AZI2';
SELECT name FROM sys.schemas WHERE name = 'bronze';

-- Check if the table exists and drop it
IF OBJECT_ID('bronze.erp_cust', 'U') IS NOT NULL  
    DROP TABLE bronze.erp_cust;  
GO
IF OBJECT_ID('dbo.erp_px_cat_G1V2', 'U') IS NOT NULL  
    DROP TABLE dbo.erp_px_cat_G1V2;  
GO

-- Create the table again
CREATE TABLE erp_cust(
	cid NVARCHAR(50),
	birthdate DATE,
	gender NVARCHAR(20)
);
-- Verify the table exists
SELECT * FROM erp_cust;

CREATE TABLE erp_px_cat_G1V2(
	id NVARCHAR(20) ,
	category NVARCHAR(50),
	subcategory NVARCHAR(50),
	Maintenance NVARCHAR(50)
);
SELECT * FROM erp_px_cat_G1V2;
