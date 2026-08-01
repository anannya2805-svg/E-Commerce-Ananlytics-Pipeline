 -- *DATA CLEANING PHASE*--


--  Creating the clean data table


CREATE TABLE clean_sales_data (
    Order_ID VARCHAR(50),          -- VARCHAR so that it allows string values like 'Unknown Order'
    Order_Date DATE,               -- Allows NULL when date is missing
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Customer_City VARCHAR(100),
    Product_ID VARCHAR(50),
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Unit_Price DECIMAL(10, 2),
    Quantity INT,
    Total_Sales DECIMAL(10, 2)     
);


-- 2. Inserting the clean data 

INSERT INTO clean_sales_data (
    Order_ID,
    Order_Date,
    Customer_ID,
    Customer_Name,
    Customer_City,
    Product_ID,
    Product_Name,
    Category,
    Unit_Price,
    Quantity,
    Total_Sales
)
SELECT DISTINCT
    -- Replacing blank/missing Order_ID with 'Unknown Order'
  
    COALESCE(NULLIF(TRIM(Order_ID), ''), 'Unknown Order') AS Order_ID,

    -- blanks become NULL
  
    CASE 
        WHEN Order_Date LIKE '%/%/%' 
            THEN STR_TO_DATE(NULLIF(TRIM(Order_Date), ''), '%d/%m/%Y')
        WHEN Order_Date LIKE '%-%-%' AND LENGTH(TRIM(Order_Date)) = 9 
            THEN STR_TO_DATE(NULLIF(TRIM(Order_Date), ''), '%d-%b-%y')
        WHEN Order_Date LIKE '%-%-%' AND LENGTH(TRIM(Order_Date)) = 10 
            THEN STR_TO_DATE(NULLIF(TRIM(Order_Date), ''), '%Y-%m-%d')
        ELSE NULL
    END AS Order_Date,

    TRIM(Customer_ID) AS Customer_ID,
    TRIM(Customer_Name) AS Customer_Name,
    TRIM(Customer_City) AS Customer_City,
    TRIM(Product_ID) AS Product_ID,
    TRIM(Product_Name) AS Product_Name,
    TRIM(Category) AS Category,

    -- Unit_Price: lookup by Product_ID if blank
  
    CASE 
        WHEN NULLIF(TRIM(Unit_Price), '') IS NOT NULL 
            THEN CAST(TRIM(Unit_Price) AS DECIMAL(10,2))
        WHEN UPPER(TRIM(Product_ID)) = 'P01' THEN 25.00
        WHEN UPPER(TRIM(Product_ID)) = 'P02' THEN 75.00
        WHEN UPPER(TRIM(Product_ID)) = 'P03' THEN 35.00
        WHEN UPPER(TRIM(Product_ID)) = 'P04' THEN 250.00
    END AS Unit_Price,

    CAST(NULLIF(TRIM(Quantity), '') AS SIGNED) AS Quantity,

    -- Total_Sales = Unit_Price * Quantity
  
    (
        CASE 
            WHEN NULLIF(TRIM(Unit_Price), '') IS NOT NULL 
                THEN CAST(TRIM(Unit_Price) AS DECIMAL(10,2))
            WHEN UPPER(TRIM(Product_ID)) = 'P01' THEN 25.00
            WHEN UPPER(TRIM(Product_ID)) = 'P02' THEN 75.00
            WHEN UPPER(TRIM(Product_ID)) = 'P03' THEN 35.00
            WHEN UPPER(TRIM(Product_ID)) = 'P04' THEN 250.00
        END 
        * CAST(NULLIF(TRIM(Quantity), '') AS SIGNED)
    ) AS Total_Sales

FROM raw_sales_data
WHERE 
    NULLIF(TRIM(Customer_ID), '') IS NOT NULL
    AND NULLIF(TRIM(Quantity), '') IS NOT NULL
    AND CAST(NULLIF(TRIM(Quantity), '') AS SIGNED) > 0;
    
    
    SELECT COUNT(*) FROM clean_sales_data;
    
    -- Turning off safe mode --
SET SQL_SAFE_UPDATES = 0;

-- Fixing New yorK

UPDATE clean_sales_data
SET Customer_City = 'New York'
WHERE TRIM(Customer_City) = 'New yorK';

--  Fixing LA

UPDATE clean_sales_data
SET Customer_City = 'Los Angeles'
WHERE TRIM(Customer_City) = 'LA';

-- Turning the safe mode back on
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;

--  Fixing ergonomic chair

UPDATE dim_product
SET Product_Name = 'Ergonomic Chair'
WHERE Product_Name = 'ergonomic chair';

SET SQL_SAFE_UPDATES = 1;

    
    SELECT DISTINCT Customer_City 
FROM clean_sales_data;
    
    
