-- *DATA EXPLORATION PHASE*--

-- 1. Creating database for the sales dataset --

CREATE DATABASE globalstore_ecom_sales_db ;

-- 2. Creating the landing table for the dirty data

USE globalstore_ecom_sales_db ;
CREATE TABLE raw_sales_data (
    Order_ID VARCHAR(50),
    Order_Date VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Customer_City VARCHAR(100),
    Product_ID VARCHAR(50),
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Unit_Price VARCHAR(50),
    Quantity VARCHAR(50),
    Total_Sales VARCHAR(50)
);



SELECT COUNT(*) AS total_records
FROM raw_sales_data;

-- Inspecting Sample Data --

SELECT * 
FROM raw_sales_data 
LIMIT 15;

-- Identifing Missing (NULL) Values --

SELECT 
    SUM(CASE WHEN Order_ID IS NULL OR Order_ID = '' THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN Order_Date IS NULL OR Order_Date = '' THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN Customer_ID IS NULL OR Customer_ID = '' THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN Customer_Name IS NULL OR Customer_Name = '' THEN 1 ELSE 0 END) AS missing_customer_name,
    SUM(CASE WHEN Customer_City IS NULL OR Customer_City = '' THEN 1 ELSE 0 END) AS missing_customer_city,
    SUM(CASE WHEN Product_ID IS NULL OR Product_ID = '' THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN Product_Name IS NULL OR Product_Name = '' THEN 1 ELSE 0 END) AS missing_product_name,
    SUM(CASE WHEN Category IS NULL OR Category = '' THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN Unit_Price IS NULL OR Unit_Price = '' THEN 1 ELSE 0 END) AS missing_unit_price,
    SUM(CASE WHEN Quantity IS NULL OR Quantity = '' THEN 1 ELSE 0 END) AS missing_quantity,
    SUM(CASE WHEN Total_Sales IS NULL OR Total_Sales = '' THEN 1 ELSE 0 END) AS missing_total_sales
FROM raw_sales_data;

-- Checking the price of each product --

SELECT DISTINCT Product_Name, Unit_Price
FROM raw_sales_data
ORDER BY Product_Name;

-- identifying duplicated rows --


SELECT Order_ID, Order_Date, Customer_ID, Customer_Name, Customer_City, 
       Product_ID, Product_Name, Quantity, 
       COUNT(*) AS times_duplicate
FROM raw_sales_data
GROUP BY Order_ID, Order_Date, Customer_ID, Customer_Name, Customer_City, 
         Product_ID, Product_Name, Quantity
HAVING COUNT(*) > 1
ORDER BY times_duplicate DESC;


-- Uncovering casing mismatches --

SELECT DISTINCT Customer_City  
FROM raw_sales_data 
ORDER BY Customer_City;

SELECT LEFT(Order_Date, 7) AS order_month, COUNT(*) AS total_orders
FROM raw_sales_data
GROUP BY order_month
ORDER BY order_month;


SELECT DISTINCT  Product_Name
FROM raw_sales_data 
ORDER BY Product_Name;

SELECT DISTINCT Category
FROM raw_sales_data 
ORDER BY  Category;


-- Cheecking Business & Numeric logic--

SELECT * 
FROM raw_sales_data 
WHERE Quantity <= 0;

SELECT Order_ID, Unit_Price, Quantity, Total_Sales, 
       (Unit_Price * Quantity) AS calculated_sales
FROM raw_sales_data
WHERE Total_Sales <> (Unit_Price * Quantity);
