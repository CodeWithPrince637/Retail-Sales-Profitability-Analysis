use Retail_Sales_Analysis
USE Retail_Sales_Analysis;
GO

CREATE TABLE dbo.Retail_Sales_Staging
(
    [Row ID] NVARCHAR(100) NULL,
    [Order ID] NVARCHAR(100) NULL,
    [Order Date] NVARCHAR(100) NULL,
    [Ship Date] NVARCHAR(100) NULL,
    [Ship Mode] NVARCHAR(100) NULL,
    [Customer ID] NVARCHAR(100) NULL,
    [Customer Name] NVARCHAR(255) NULL,
    [Segment] NVARCHAR(100) NULL,
    [City] NVARCHAR(255) NULL,
    [State] NVARCHAR(255) NULL,
    [Country] NVARCHAR(255) NULL,
    [Postal Code] NVARCHAR(100) NULL,
    [Market] NVARCHAR(100) NULL,
    [Region] NVARCHAR(100) NULL,
    [Product ID] NVARCHAR(100) NULL,
    [Category] NVARCHAR(100) NULL,
    [Sub-Category] NVARCHAR(100) NULL,
    [Product Name] NVARCHAR(500) NULL,
    [Sales] NVARCHAR(100) NULL,
    [Quantity] NVARCHAR(100) NULL,
    [Discount] NVARCHAR(100) NULL,
    [Profit] NVARCHAR(100) NULL,
    [Shipping Cost] NVARCHAR(100) NULL,
    [Order Priority] NVARCHAR(100) NULL
);
BULK INSERT dbo.Retail_Sales_Staging
FROM 'C:\SQLData\Global_Superstore2.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    KEEPNULLS,
    TABLOCK
);
select * from [dbo].[Global_Superstore]
SELECT COUNT(*) AS Total_Records
FROM dbo.Global_Superstore
SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Global_Superstore'
SELECT TOP 10 *
FROM dbo.Global_Superstore;
use [Retail_Sales_Analysis]
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Order ID]) AS Unique_Orders,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers,
    COUNT(DISTINCT [Product ID]) AS Unique_Products
select * FROM dbo.Global_Superstore
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Order ID]) AS Unique_Orders,
    COUNT(DISTINCT [Customer ID]) AS Unique_Customers,
    COUNT(DISTINCT [Product ID]) AS Unique_Products
FROM dbo.Global_Superstore;
USE Retail_Sales_Analysis;
GO

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT [Order_ID]) AS Unique_Orders,
    COUNT(DISTINCT [Customer_ID]) AS Unique_Customers,
    COUNT(DISTINCT [Product_ID]) AS Unique_Products
FROM dbo.Global_Superstore;
SELECT
    COUNT(*) AS Total_Rows,
    COUNT([Order_Date]) AS Order_Date_Count,
    COUNT([Ship_Date]) AS Ship_Date_Count,
    COUNT([Sales]) AS Sales_Count,
    COUNT([Profit]) AS Profit_Count,
    COUNT([Discount]) AS Discount_Count
FROM dbo.Global_Superstore;
SELECT *
FROM dbo.Global_Superstore
WHERE [Profit] IS NULL;
SELECT
    Country,
    COUNT(*) AS Missing_Profit_Records
FROM dbo.Global_Superstore
WHERE Profit IS NULL
GROUP BY Country
ORDER BY Missing_Profit_Records DESC;
SELECT
    COUNT(*) AS Missing_Profit_Rows,
    SUM(Sales) AS Sales_Of_Missing_Profit,
    SUM(Quantity) AS Quantity_Of_Missing_Profit
FROM dbo.Global_Superstore
WHERE Profit IS NULL;
SELECT
    Row_ID,
    COUNT(*) AS Duplicate_Count
FROM dbo.Global_Superstore
GROUP BY Row_ID
HAVING COUNT(*) > 1;
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Date,
    SUM(CASE WHEN Ship_Date IS NULL THEN 1 ELSE 0 END) AS Missing_Ship_Date,
    SUM(CASE WHEN Ship_Date < Order_Date THEN 1 ELSE 0 END) AS Invalid_Date_Sequence
FROM dbo.Global_Superstore;
SELECT
    COUNT(CASE WHEN Sales <= 0 THEN 1 END) AS Invalid_Sales,
    COUNT(CASE WHEN Quantity <= 0 THEN 1 END) AS Invalid_Quantity,
    COUNT(CASE WHEN Discount < 0 OR Discount > 1 THEN 1 END) AS Invalid_Discount,
    COUNT(CASE WHEN [Shipping_Cost] < 0 THEN 1 END) AS Invalid_Shipping_Cost
FROM dbo.Global_Superstore;
SELECT
    Row_ID,
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    City,
    State,
    Country,
    Postal_Code,
    Market,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Discount,
    Profit,
    Shipping_Cost,
    Order_Priority,
    COUNT(*) AS Duplicate_Count
FROM dbo.Global_Superstore
GROUP BY
    Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode,
    Customer_ID, Customer_Name, Segment, City, State,
    Country, Postal_Code, Market, Region, Product_ID,
    Category, Sub_Category, Product_Name, Sales, Quantity,
    Discount, Profit, Shipping_Cost, Order_Priority
HAVING COUNT(*) > 1;