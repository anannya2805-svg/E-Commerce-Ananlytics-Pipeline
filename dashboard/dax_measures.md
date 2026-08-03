# DAX Measures Used in Dashboard

## Total Orders
Total Orders = COUNT(fact_sales[Order_ID])

## Median Order Value
Median Order Value = MEDIAN(fact_sales[Total_Sales])

## Sales Standard Deviation
Sales Standard Deviation = STDEV.P(fact_sales[Total_Sales])

## Revenue Target
Revenue Target = <br>
VAR SelectedQuarter = <br>
    SELECTEDVALUE('fact_sales'[Order_Date].[Quarter]) <br>
RETURN <br>
SWITCH(   <br>
    SelectedQuarter,<br>
    "Qtr 1", 14000,<br>
    "Qtr 2", 14000,<br>
    "Qtr 3", 13500,<br>
    "Qtr 4", 16000,<br>
    57500 <br>
)
## Target Achievement %
Target Achievement % = DIVIDE([Total Revenue],[Revenue Target]) * 100
