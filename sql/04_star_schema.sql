-- Building Dim And Fact Tables for Star Schema--

-- Dimension Tables

CREATE TABLE Dim_Customer AS
SELECT DISTINCT
    Customer_ID,
    Customer_Name,
    Customer_City
FROM clean_sales_data;


CREATE TABLE Dim_Product AS
SELECT DISTINCT
    Product_ID,
    Product_Name,
    Category,
    Unit_Price
FROM clean_sales_data;


-- Fact Table

CREATE TABLE Fact_Sales AS
SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Product_ID,
    Quantity,
    Unit_Price,
    Total_Sales
FROM clean_sales_data;


-- Verify Tables

SELECT * FROM Dim_Customer;
SELECT * FROM Dim_Product;
SELECT * FROM Dim_Date;
SELECT * FROM Fact_Sales;

SELECT COUNT(*) FROM Dim_Customer;
SELECT COUNT(*) FROM Dim_Product;
SELECT COUNT(*) FROM Dim_Date;
SELECT COUNT(*) FROM Fact_Sales;
