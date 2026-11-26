
USE Retail_Sales_Analysis;
GO

-- Top 10 products by sales
SELECT TOP 10
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    SUM(Quantity) AS Total_Quantity,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Global_Superstore
GROUP BY Product_ID, Product_Name, Category, Sub_Category
ORDER BY Total_Sales DESC;


-- Top 10 products by profit
SELECT TOP 10
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Global_Superstore
GROUP BY Product_ID, Product_Name, Category, Sub_Category
ORDER BY Total_Profit DESC;


-- Loss-making products
SELECT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Global_Superstore
GROUP BY Product_ID, Product_Name, Category, Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;


-- High sales but loss-making products
SELECT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin
FROM dbo.Global_Superstore
GROUP BY Product_ID, Product_Name, Category, Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Total_Sales DESC;


-- Category and sub-category contribution
WITH Product_Performance AS
(
    SELECT
        Category,
        Sub_Category,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit,
        SUM(Quantity) AS Total_Quantity
    FROM dbo.Global_Superstore
    GROUP BY Category, Sub_Category
)
SELECT
    Category,
    Sub_Category,
    Total_Sales,
    Total_Profit,
    Total_Quantity,
    CAST(
        Total_Sales * 100.0 /
        NULLIF(SUM(Total_Sales) OVER(), 0)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM Product_Performance
ORDER BY Total_Sales DESC;
