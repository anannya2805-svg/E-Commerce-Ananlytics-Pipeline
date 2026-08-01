# DAX Measures Used in Dashboard

## Total Orders
Total Orders = COUNT(fact_sales[Order_ID])

## Median Order Value
MEDIAN(fact_sales[Total_Sales])

## Sales Standard Deviation
STDEV.P(fact_sales[Total_Sales])

## Revenue Target
Revenue Target = 
VAR SelectedQuarter = 
    SELECTEDVALUE('fact_sales'[Order_Date].[Quarter])
RETURN
SWITCH(
    SelectedQuarter,
    "Qtr 1", 14000,
    "Qtr 2", 14000,
    "Qtr 3", 13500,
    "Qtr 4", 16000,
    57500
)

## Target Achievement %
DIVIDE([Total Revenue],[Revenue Target]) * 100
