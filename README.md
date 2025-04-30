# Task 6: Sales Trend Analysis using SQL (SQLite)

## Dataset Used:
Custom dataset named `online_sales_dataset` with generic field names (`field1` to `field17`).

## Objective:
1. Extract relevant fields to create a clean `online_sales` table.
2. Perform a monthly sales trend analysis.

## SQL Scripts:
```sql
-- Step 1: Create `online_sales` table
CREATE TABLE online_sales AS
SELECT 
    field5 AS order_date,              -- InvoiceDate
    field2 AS product_id,              -- StockCode
    field1 AS InvoiceNo,               -- InvoiceNo
    field4 AS Quantity,                -- Quantity
    field6 AS UnitPrice,               -- UnitPrice
    field9 AS Discount,                -- Discount
    (field4 * field6 - COALESCE(field9, 0)) AS amount
FROM 
    online_sales_dataset;

-- Step 2: Sales Trend Analysis Query
SELECT 
    STRFTIME('%Y', order_date) AS year,
    STRFTIME('%m', order_date) AS month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM 
    online_sales
GROUP BY 
    year, month
ORDER BY 
    year, month;
