-- Create a temporary table to store our transaction data
CREATE TEMPORARY TABLE transactions (
    transaction_id INT,
    order_date DATE,
    product_category VARCHAR(50),
    product_name VARCHAR(50),
    units_sold INT,
    unit_price DECIMAL(10, 2),
    total_revenue DECIMAL(10, 2),
    region VARCHAR(50),
    payment_method VARCHAR(50)
);

-- Insert sample data
INSERT INTO transactions VALUES 
(10001, '2024-01-01', 'Electronics', 'iPhone 14 Pro', 2, 999.99, 1999.98, 'North America', 'Credit Card'),
(10002, '2024-01-02', 'Home Appliances', 'Dyson V11 Vacuum', 1, 499.99, 499.99, 'Europe', 'PayPal'),
(10003, '2024-01-03', 'Clothing', 'Levi''s 501 Jeans', 3, 69.99, 209.97, 'Asia', 'Debit Card');

-- 1. Monthly Revenue and Order Volume Analysis
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(total_revenue) AS monthly_revenue,
    COUNT(DISTINCT transaction_id) AS order_volume
FROM 
    transactions
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY 
    year, month;

-- 2. Product Category Performance Analysis
SELECT 
    product_category,
    SUM(units_sold) AS total_units_sold,
    SUM(total_revenue) AS category_revenue,
    COUNT(DISTINCT transaction_id) AS order_count
FROM 
    transactions
GROUP BY 
    product_category
ORDER BY 
    category_revenue DESC;

-- 3. Regional Sales Analysis
SELECT 
    region,
    SUM(total_revenue) AS regional_revenue,
    COUNT(DISTINCT transaction_id) AS order_count,
    AVG(total_revenue) AS average_order_value
FROM 
    transactions
GROUP BY 
    region
ORDER BY 
    regional_revenue DESC;

-- 4. Payment Method Analysis
SELECT 
    payment_method,
    COUNT(*) AS transaction_count,
    SUM(total_revenue) AS payment_method_revenue,
    ROUND(AVG(total_revenue), 2) AS average_transaction_value
FROM 
    transactions
GROUP BY 
    payment_method
ORDER BY 
    payment_method_revenue DESC;

-- 5. Combined Monthly Analysis with Multiple Metrics
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT transaction_id) AS order_count,
    SUM(units_sold) AS total_units_sold,
    SUM(total_revenue) AS total_revenue,
    ROUND(AVG(total_revenue), 2) AS average_order_value,
    COUNT(DISTINCT product_category) AS unique_categories_sold
FROM 
    transactions
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY 
    year, month
LIMIT 12; -- Limiting to the most recent 12 months (modify as needed)
