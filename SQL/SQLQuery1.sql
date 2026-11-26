USE Retail_Sales_Analysis;
GO

-- Overall Business Performance
SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    COUNT(DISTINCT Product_ID) AS Unique_Products,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM dbo.Global_Superstore;


-- Quarter-wise Sales and Profit Analysis

SELECT
    YEAR(Order_Date) AS Sales_Year,
    DATEPART(QUARTER, Order_Date) AS Sales_Quarter,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity

FROM dbo.Global_Superstore

GROUP BY
    YEAR(Order_Date),
    DATEPART(QUARTER, Order_Date)

ORDER BY
    Sales_Year,
    Sales_Quarter;
    -- Best Performing Month

SELECT TOP 1
    YEAR(Order_Date) AS Sales_Year,
    MONTH(Order_Date) AS Sales_Month,
    DATENAME(MONTH, Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Global_Superstore
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date)
ORDER BY
    Total_Sales DESC;
    -- Worst Performing Month

SELECT TOP 1
    YEAR(Order_Date) AS Sales_Year,
    MONTH(Order_Date) AS Sales_Month,
    DATENAME(MONTH, Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Global_Superstore
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date)
ORDER BY
    Total_Sales ASC;
    
-- Month-over-Month Sales Growth Analysis

WITH Monthly_Sales AS
(
    SELECT
        DATEFROMPARTS(YEAR(Order_Date), MONTH(Order_Date), 1) AS Sales_Month,
        SUM(Sales) AS Total_Sales
    FROM dbo.Global_Superstore
    GROUP BY
        YEAR(Order_Date),
        MONTH(Order_Date)
),
Monthly_Comparison AS
(
    SELECT
        Sales_Month,
        Total_Sales,
        LAG(Total_Sales) OVER (ORDER BY Sales_Month) AS Previous_Month_Sales
    FROM Monthly_Sales
)
SELECT
    Sales_Month,
    Total_Sales,
    Previous_Month_Sales,
    Total_Sales - Previous_Month_Sales AS Sales_Difference,
    ROUND(
        (Total_Sales - Previous_Month_Sales) * 100.0
        / NULLIF(Previous_Month_Sales, 0),
        2
    ) AS MoM_Growth_Percentage
FROM Monthly_Comparison
ORDER BY Sales_Month;
