1. Step 1: Creating the online_sales table (from raw dataset)


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


2. Step 2: Performing the Sales Trend Analysis


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