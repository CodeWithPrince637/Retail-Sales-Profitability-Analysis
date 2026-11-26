
USE Retail_Sales_Analysis;
GO

-- Region-wise sales and profit

SELECT
    Region,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin
FROM dbo.Global_Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;


-- Market-wise sales and profit

SELECT
    Market,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin
FROM dbo.Global_Superstore
GROUP BY Market
ORDER BY Total_Sales DESC;


-- Top 10 countries by sales

SELECT TOP 10
    Country,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin
FROM dbo.Global_Superstore
GROUP BY Country
ORDER BY Total_Sales DESC;


-- State-wise loss analysis

SELECT
    Country,
    State,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM dbo.Global_Superstore
GROUP BY Country, State
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;


-- Best and worst performing regions

SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin,
    RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank,
    RANK() OVER (ORDER BY SUM(Profit) ASC) AS Loss_Rank
FROM dbo.Global_Superstore
GROUP BY Region
ORDER BY Profit_Rank;
