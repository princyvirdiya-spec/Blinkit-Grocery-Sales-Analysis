-- 1.View Complete Blinkit Dataset
SELECT * FROM blinkitdb.`blinkit grocery data excel`;

-- 2. Total Number of Records in Dataset
SELECT COUNT(*) FROM blinkitdb.`blinkit grocery data excel`;

-- 3. Data Cleaning: Standardize Item_Fat_Content Values
UPDATE `blinkit grocery data excel`
SET Item_Fat_Content =
CASE
    WHEN Item_Fat_Content IN ('LF','low fat') THEN 'low fat'
    WHEN Item_Fat_Content = 'reg' THEN 'Regular'
    ELSE Item_Fat_Content
END;

-- 4.Calculate Total Sales (Basic)
SELECT SUM(Sales) FROM blinkitdb.`blinkit grocery data excel`;

-- 5.Calculate Total Sales with Alias
SELECT SUM(Sales) AS Total_Sales  FROM blinkitdb.`blinkit grocery data excel`;

-- 6.Select Active Database
USE blinkitdb;

-- 7.Disable Safe Update Mode (For Data Cleaning)
SET SQL_SAFE_UPDATES = 0;

-- 8.View Distinct Fat Content Categories
SELECT DISTINCT (Item_Fat_Content)FROM blinkitdb.`blinkit grocery data excel`;

-- 9. Total Sales in Millions
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions  
FROM blinkitdb.`blinkit grocery data excel`;

-- 10. Average Sales (Basic)
SELECT AVG(SALES) FROM blinkitdb.`blinkit grocery data excel`;

-- 11.Average Sales with Alias
SELECT AVG(SALES) AS AVG_SALES FROM blinkitdb.`blinkit grocery data excel`;

-- 12. Average Sales Rounded (No Decimals)
SELECT CAST(AVG(Sales) AS DECIMAL(10,0)) AS Total_Sales_Millions  
FROM blinkitdb.`blinkit grocery data excel`;

-- 13.Average Sales Rounded (1 Decimal)
SELECT CAST(AVG(Sales) AS DECIMAL(10,1)) AS Total_Sales_Millions  
FROM blinkitdb.`blinkit grocery data excel`;

-- 14.Total Number of Items Sold
SELECT COUNT(*) AS No_Of_Items FROM blinkitdb.`blinkit grocery data excel`;

-- 15.Total Sales (Low Fat Items Only)
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions  
FROM blinkitdb.`blinkit grocery data excel` WHERE Item_Fat_Content='low fat';

-- 16.Total Sales for Outlets Established in 2022
SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions  
FROM blinkitdb.`blinkit grocery data excel` WHERE Outlet_Establishment_Year= 2022;

-- 17.Number of Items for Outlets Established in 2022
SELECT COUNT(*) AS No_Of_Items   
FROM blinkitdb.`blinkit grocery data excel` WHERE Outlet_Establishment_Year= 2022;

-- 18.Average Customer Rating
SELECT AVG(Rating) FROM blinkitdb.`blinkit grocery data excel`;

-- 19. Sales Analysis by Fat Content
SELECT 
    Item_Fat_Content, 
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkitdb.`blinkit grocery data excel`
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

-- 20. Item Type Performance Analysis (Year 2020 – Thousands)
SELECT 
    Item_Type, 
    CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items ,
    CAST(AVG(Rating) AS Decimal(10,2)) AS Avg_Rating
FROM blinkitdb.`blinkit grocery data excel`
WHERE Outlet_Establishment_Year=2020
GROUP BY Item_Type
ORDER BY Total_Sales_Thousands DESC;

-- 21. Item Type Performance Analysis (Year 2020 – Full Sales)
SELECT 
    Item_Type, 
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items ,
    CAST(AVG(Rating) AS Decimal(10,2)) AS Avg_Rating
FROM blinkitdb.`blinkit grocery data excel`
WHERE Outlet_Establishment_Year=2020
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

-- 22. Top 5 Best-Selling Item Types (2020)
SELECT 
    Item_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkitdb.`blinkit grocery data excel`
WHERE Outlet_Establishment_Year = 2020
GROUP BY Item_Type
ORDER BY Total_Sales DESC
LIMIT 5;

-- 23. Bottom 5 Lowest-Selling Item Types (2020)
SELECT 
    Item_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkitdb.`blinkit grocery data excel`
WHERE Outlet_Establishment_Year = 2020
GROUP BY Item_Type
ORDER BY Total_Sales ASC
LIMIT 5;

-- 24. Sales by Outlet Location & Fat Content (2020)
SELECT 
    Outlet_Location_Type, Item_Fat_Content,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkitdb.`blinkit grocery data excel`
WHERE Outlet_Establishment_Year = 2020
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Total_Sales ASC
limit 5;

-- 25. Sales Summary for Year 2020
SELECT 
    Outlet_Establishment_Year, 
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
    FROM blinkitdb.`blinkit grocery data excel`
WHERE Outlet_Establishment_Year = 2020
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales DESC;

-- 26. Sales Contribution by Outlet Size (Percentage Analysis)
SELECT  
    Outlet_Size,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        (SUM(Sales) * 100.0) / SUM(SUM(Sales)) OVER ()
        AS DECIMAL(10,2)
    ) AS Sales_Percentage
FROM blinkitdb.`blinkit grocery data excel`
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- 27. Sales Analysis by Outlet Location Type
SELECT  
    Outlet_Location_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        (SUM(Sales) * 100.0) / SUM(SUM(Sales)) OVER ()
        AS DECIMAL(10,2)
    ) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkitdb.`blinkit grocery data excel`
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- 28. Sales Analysis by Outlet Location Type (2020 Only)
SELECT  
    Outlet_Location_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        (SUM(Sales) * 100.0) / SUM(SUM(Sales)) OVER ()
        AS DECIMAL(10,2)
    ) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkitdb.`blinkit grocery data excel`
WHERE Outlet_Establishment_Year=2020
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- 29. Sales Analysis by Outlet Type
SELECT  
    Outlet_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        (SUM(Sales) * 100.0) / SUM(SUM(Sales)) OVER ()
        AS DECIMAL(10,2)
    ) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkitdb.`blinkit grocery data excel`
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;



