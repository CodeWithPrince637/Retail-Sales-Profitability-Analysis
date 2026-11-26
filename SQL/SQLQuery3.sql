USE Retail_Sales_Analysis;
GO

-- Discount-wise Sales and Profit Analysis

SELECT
    Discount,
    COUNT(*) AS Total_Records,
    SUM(Quantity) AS Total_Quantity,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percentage

FROM dbo.Global_Superstore

GROUP BY Discount

ORDER BY Discount;
USE Retail_Sales_Analysis;
GO

-- Discount Range-wise Profitability

SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.10 THEN '1-10%'
        WHEN Discount <= 0.20 THEN '11-20%'
        WHEN Discount <= 0.30 THEN '21-30%'
        ELSE 'Above 30%'
    END AS Discount_Range,

    COUNT(*) AS Total_Records,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,

    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percentage

FROM dbo.Global_Superstore

GROUP BY
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.10 THEN '1-10%'
        WHEN Discount <= 0.20 THEN '11-20%'
        WHEN Discount <= 0.30 THEN '21-30%'
        ELSE 'Above 30%'
    END

ORDER BY MIN(Discount);
USE Retail_Sales_Analysis;
GO

-- High Discount Loss Analysis (Above 20%)

SELECT
    Discount,
    COUNT(*) AS Total_Records,

    SUM(CASE
        WHEN Profit < 0 THEN 1
        ELSE 0
    END) AS Loss_Records,

    SUM(CASE
        WHEN Profit >= 0 THEN 1
        ELSE 0
    END) AS Profitable_Records,

    SUM(Profit) AS Total_Profit,
    SUM(Sales) AS Total_Sales

FROM dbo.Global_Superstore

WHERE Discount > 0.20

GROUP BY Discount

ORDER BY Discount;
USE Retail_Sales_Analysis;
GO

-- Category-wise Discount Impact

SELECT
    Category,
    Discount,

    COUNT(*) AS Total_Records,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,

    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percentage,

    SUM(CASE
        WHEN Profit < 0 THEN 1
        ELSE 0
    END) AS Loss_Records

FROM dbo.Global_Superstore

GROUP BY
    Category,
    Discount

ORDER BY
    Category,
    Discount;