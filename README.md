# 🛒 Global Store E-Commerce Analysis

## 📌 Project Overview
An end-to-end data analysis project 
analyzing e-commerce sales data to 
uncover business insights using 
MySQL and Power BI.

---

## 🛠️ Tools Used
- MySQL — Data exploration, cleaning & validation 
- Power BI — Dashboard & visualization
- DAX — Calculated measures

---

## 🔄 Project Pipeline
Raw Data → Data Cleaning → 
Star Schema → Dashboard → Insights

---

## 📊 Dashboard Preview
![Overview](screenshots/overview.png)
![Products](screenshots/product_analysis.png)

---

## 💡 Key Business Insights
1. Ergonomic Chair generates 39K — 
   70% of total revenue — making it 
   the most critical product for 
   the business

2. Wireless Mouse sold most units (172) 
   but earned least revenue (4K) while 
   Ergonomic Chair earned 39K from 
   156 units — high volume does not 
   always mean high revenue

3. New York earned lowest revenue (7K) 
   despite being a major market — 
   Phoenix led with 15.2K showing 
   a clear untapped opportunity 
   in New York

4. Furniture alone drives 70% of revenue 
   with Electronics at 20% and Office 
   Supplies at 10% — heavy dependency 
   on one category is a business risk

5. September 2023 was the lowest 
   performing month of the year — 
   indicating a seasonal dip that 
   requires planned attention

6. Sales standard deviation of 331.39 
   exceeds median order value of 125 — 
   revenue is largely driven by 
   occasional large orders making 
   it inconsistent and unpredictable



---

## ✅ Business Recommendations
1. Maintain strong stock levels for 
   Ergonomic Chair at all times as 
   it drives 70% of total revenue

2. Bundle Wireless Mouse with Mechanical 
   Keyboard or Desk Lamp as combo offers 
   to increase revenue per order

3. Increase marketing focus on New York 
   to unlock its underperforming 
   but high potential market

4. Promote Electronics and Office Supplies 
   more actively to reduce dependency 
   on the Furniture category

5. Run discount offers and sales 
   campaigns in September every year 
   to attract more customers during 
   the lowest performing month

6. Encourage medium value orders in the 
   250 to 500 range to build more 
   consistent and predictable revenue
---

## 📁 Repository Structure
- data/ — Raw dataset
- sql/ — All SQL queries
- dashboard/ — PDF dashboard
- screenshots/ — Dashboard previews

---

## ⚠️ Limitations
1. Small Dataset
   Only 192 records however the variety 
   of errors made it sufficient to 
   demonstrate a complete data 
   cleaning workflow.

2. Single Year Data
   Data covers only 2023 so year 
   over year comparison is not possible.

3. NULL Dates Affect Monthly Trend
   Some records have missing dates 
   making monthly trend approximate.
   Rows were kept intentionally to 
   preserve valid sales and quantity data.

4. No Profit Data
   Dataset only contains revenue — 
   actual profitability of products 
   and cities cannot be determined.
