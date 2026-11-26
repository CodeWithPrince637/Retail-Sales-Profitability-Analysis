
USE Retail_Sales_Analysis;
GO

-- Shipping mode performance

SELECT
    Ship_Mode,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Shipping_Cost) AS Total_Shipping_Cost,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin
FROM dbo.Global_Superstore
GROUP BY Ship_Mode
ORDER BY Total_Sales DESC;


-- Average shipping days

WITH Order_Shipping AS
(
    SELECT
        Order_ID,
        Ship_Mode,
        MIN(Order_Date) AS Order_Date,
        MIN(Ship_Date) AS Ship_Date
    FROM dbo.Global_Superstore
    GROUP BY Order_ID, Ship_Mode
)
SELECT
    Ship_Mode,
    COUNT(*) AS Total_Orders,
    AVG(CAST(DATEDIFF(DAY, Order_Date, Ship_Date) AS DECIMAL(10,2)))
        AS Average_Shipping_Days
FROM Order_Shipping
GROUP BY Ship_Mode
ORDER BY Average_Shipping_Days;


-- Shipping duration distribution

WITH Order_Shipping AS
(
    SELECT
        Order_ID,
        Ship_Mode,
        MIN(Order_Date) AS Order_Date,
        MIN(Ship_Date) AS Ship_Date
    FROM dbo.Global_Superstore
    GROUP BY Order_ID, Ship_Mode
)
SELECT
    Ship_Mode,
    DATEDIFF(DAY, Order_Date, Ship_Date) AS Shipping_Days,
    COUNT(*) AS Total_Orders
FROM Order_Shipping
GROUP BY
    Ship_Mode,
    DATEDIFF(DAY, Order_Date, Ship_Date)
ORDER BY Ship_Mode, Shipping_Days;


-- Shipping cost compared with sales and profit

SELECT
    Ship_Mode,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Shipping_Cost) AS Total_Shipping_Cost,
    CAST(
        SUM(Shipping_Cost) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Shipping_Cost_Percentage,
    CAST(
        SUM(Shipping_Cost) * 100.0 / NULLIF(SUM(Profit), 0)
        AS DECIMAL(10,2)
    ) AS Shipping_Cost_To_Profit_Percentage
FROM dbo.Global_Superstore
GROUP BY Ship_Mode
ORDER BY Total_Shipping_Cost DESC;
