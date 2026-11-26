
USE Retail_Sales_Analysis;
GO

-- Customer value analysis using CTE

WITH Customer_Summary AS
(
    SELECT
        Customer_ID,
        Customer_Name,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM dbo.Global_Superstore
    GROUP BY Customer_ID, Customer_Name
)
SELECT
    Customer_ID,
    Customer_Name,
    Total_Sales,
    Total_Profit,
    CASE
        WHEN Total_Sales >= 10000 THEN 'High Value'
        WHEN Total_Sales >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Customer_Value
FROM Customer_Summary
ORDER BY Total_Sales DESC;


-- Products performing above average sales using subquery

SELECT
    Product_ID,
    Product_Name,
    Category,
    SUM(Sales) AS Total_Sales
FROM dbo.Global_Superstore
GROUP BY Product_ID, Product_Name, Category
HAVING SUM(Sales) >
(
    SELECT AVG(Product_Sales)
    FROM
    (
        SELECT
            Product_ID,
            SUM(Sales) AS Product_Sales
        FROM dbo.Global_Superstore
        GROUP BY Product_ID
    ) AS Product_Average
)
ORDER BY Total_Sales DESC;


-- First order placed by each customer using ROW_NUMBER

WITH Order_Summary AS
(
    SELECT
        Customer_ID,
        Customer_Name,
        Order_ID,
        MIN(Order_Date) AS Order_Date,
        SUM(Sales) AS Order_Sales
    FROM dbo.Global_Superstore
    GROUP BY Customer_ID, Customer_Name, Order_ID
),
Customer_First_Order AS
(
    SELECT
        *,
        ROW_NUMBER() OVER
        (
            PARTITION BY Customer_ID
            ORDER BY Order_Date, Order_ID
        ) AS Order_Rank
    FROM Order_Summary
)
SELECT
    Customer_ID,
    Customer_Name,
    Order_ID,
    Order_Date AS First_Order_Date,
    Order_Sales
FROM Customer_First_Order
WHERE Order_Rank = 1
ORDER BY First_Order_Date;


-- Sub-category profit ranking within each category

SELECT
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    RANK() OVER
    (
        PARTITION BY Category
        ORDER BY SUM(Profit) DESC
    ) AS Profit_Rank,
    DENSE_RANK() OVER
    (
        PARTITION BY Category
        ORDER BY SUM(Profit) DESC
    ) AS Dense_Profit_Rank
FROM dbo.Global_Superstore
GROUP BY Category, Sub_Category
ORDER BY Category, Profit_Rank;


-- Year-over-year sales growth using LAG

WITH Yearly_Sales AS
(
    SELECT
        YEAR(Order_Date) AS Sales_Year,
        SUM(Sales) AS Total_Sales
    FROM dbo.Global_Superstore
    GROUP BY YEAR(Order_Date)
),
Previous_Year_Sales AS
(
    SELECT
        Sales_Year,
        Total_Sales,
        LAG(Total_Sales) OVER
        (
            ORDER BY Sales_Year
        ) AS Previous_Year_Sales
    FROM Yearly_Sales
)
SELECT
    Sales_Year,
    Total_Sales,
    Previous_Year_Sales,
    Total_Sales - Previous_Year_Sales AS Sales_Difference,
    CAST(
        (Total_Sales - Previous_Year_Sales) * 100.0 /
        NULLIF(Previous_Year_Sales, 0)
        AS DECIMAL(10,2)
    ) AS YoY_Growth_Percentage
FROM Previous_Year_Sales
ORDER BY Sales_Year;


-- Top 3 products by sales within each category

WITH Product_Sales AS
(
    SELECT
        Product_ID,
        Product_Name,
        Category,
        Sub_Category,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM dbo.Global_Superstore
    GROUP BY Product_ID, Product_Name, Category, Sub_Category
),
Product_Ranking AS
(
    SELECT
        *,
        ROW_NUMBER() OVER
        (
            PARTITION BY Category
            ORDER BY Total_Sales DESC, Product_ID
        ) AS Product_Rank
    FROM Product_Sales
)
SELECT
    Category,
    Product_ID,
    Product_Name,
    Sub_Category,
    Total_Sales,
    Total_Profit,
    Product_Rank
FROM Product_Ranking
WHERE Product_Rank <= 3
ORDER BY Category, Product_Rank;
