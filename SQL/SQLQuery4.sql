
USE Retail_Sales_Analysis;
GO

-- =====================================================
-- TASK 1: TOP 10 CUSTOMERS BY SALES
-- Business Goal: Identify customers generating highest revenue
-- =====================================================

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    Segment,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Global_Superstore
GROUP BY
    Customer_ID,
    Customer_Name,
    Segment
ORDER BY
    Total_Sales DESC;


-- =====================================================
-- TASK 2: TOP 10 CUSTOMERS BY PROFIT
-- Business Goal: Identify customers contributing highest profit
-- =====================================================

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    Segment,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Global_Superstore
GROUP BY
    Customer_ID,
    Customer_Name,
    Segment
ORDER BY
    Total_Profit DESC;


-- =====================================================
-- TASK 3: LOSS-MAKING CUSTOMERS
-- Business Goal: Find customers whose total business is loss-making
-- =====================================================

SELECT
    Customer_ID,
    Customer_Name,
    Segment,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Global_Superstore
GROUP BY
    Customer_ID,
    Customer_Name,
    Segment
HAVING SUM(Profit) < 0
ORDER BY
    Total_Profit ASC;


-- =====================================================
-- TASK 4: CUSTOMER-WISE SALES, PROFIT AND PROFIT MARGIN
-- Business Goal: Measure customer-level profitability
-- =====================================================

SELECT
    Customer_ID,
    Customer_Name,
    Segment,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin_Percentage
FROM dbo.Global_Superstore
GROUP BY
    Customer_ID,
    Customer_Name,
    Segment
ORDER BY
    Total_Sales DESC;


-- =====================================================
-- TASK 5: CUSTOMER SEGMENT ANALYSIS
-- Business Goal: Compare Consumer, Corporate and Home Office
-- =====================================================

SELECT
    Segment,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0)
        AS DECIMAL(10,2)
    ) AS Profit_Margin_Percentage
FROM dbo.Global_Superstore
GROUP BY
    Segment
ORDER BY
    Total_Sales DESC;
