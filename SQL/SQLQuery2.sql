use [Retail_Sales_Analysis]
USE Retail_Sales_Analysis;
GO

-- Category-wise Sales and Profit Analysis

SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percentage

FROM dbo.Global_Superstore

GROUP BY Category

ORDER BY Total_Sales DESC;
USE Retail_Sales_Analysis;
GO

-- Sub-Category-wise Sales and Profit Analysis

SELECT
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percentage

FROM dbo.Global_Superstore

GROUP BY
    Category,
    Sub_Category

ORDER BY
    Total_Profit DESC;
    USE Retail_Sales_Analysis;
GO

-- Top 5 Most Profitable Sub-Categories

SELECT TOP 5
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity

FROM dbo.Global_Superstore

GROUP BY
    Category,
    Sub_Category

ORDER BY
    Total_Profit DESC;
    USE Retail_Sales_Analysis;
GO

-- Bottom 5 Least Profitable Sub-Categories

SELECT TOP 5
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity

FROM dbo.Global_Superstore

GROUP BY
    Category,
    Sub_Category

ORDER BY
    Total_Profit ASC;