-- *DATA VALIDATION PHASE*--
    
  -- AUDIT 1: Excluded Records Audit
-- (Verifies why rows were dropped from raw_sales_data)

    SELECT 
    COUNT(*) AS total_raw_rows,
    SUM(CASE WHEN CAST(NULLIF(TRIM(Quantity), '') AS SIGNED) <= 0 THEN 1 ELSE 0 END) AS dropped_negative_returns,
    SUM(CASE WHEN NULLIF(TRIM(Customer_ID), '') IS NULL THEN 1 ELSE 0 END) AS dropped_missing_customers,
    SUM(CASE WHEN NULLIF(TRIM(Quantity), '') IS NULL THEN 1 ELSE 0 END) AS dropped_missing_quantity
FROM raw_sales_data;


-- AUDIT 2: Deduplication Audit
-- (Counts rows before vs. after DISTINCT)

SELECT COUNT(*) AS rows_before_distinct
FROM raw_sales_data
WHERE 
    NULLIF(TRIM(Customer_ID), '') IS NOT NULL
    AND NULLIF(TRIM(Quantity), '') IS NOT NULL
    AND CAST(NULLIF(TRIM(Quantity), '') AS SIGNED) > 0;

    
-- AUDIT 3: Data Cleaning & Default Value Audit
-- (Verifies fallbacks were correctly applied in clean_sales_data)

SELECT 
    SUM(CASE WHEN Order_ID = 'Unknown Order' THEN 1 ELSE 0 END) AS saved_unknown_order_ids,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS saved_missing_dates,
    SUM(CASE WHEN Unit_Price IS NOT NULL AND Quantity IS NOT NULL THEN 1 ELSE 0 END) AS valid_sales_rows
FROM clean_sales_data;


-- AUDIT 4: Star Schema Relationship Audit (JOIN Check)
-- Checks for missing connections between sales data and product lists

-- Check missing customers
SELECT f.Order_ID, f.Customer_ID
FROM Fact_Sales f
LEFT JOIN Dim_Customer c ON f.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

-- Check missing products
SELECT f.Order_ID, f.Product_ID
FROM Fact_Sales f
LEFT JOIN Dim_Product p ON f.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;
