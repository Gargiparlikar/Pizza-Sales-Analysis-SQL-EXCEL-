# 1 KPI Requirement 

SELECT * FROM pizzadb.pizza_sales;

# Total Revenue

SELECT SUM(total_Price) AS Total_Revenue FROM pizza_sales;  # 817860.0508384705

# Average Order VALUE

SELECT SUM(total_Price) / COUNT(DISTINCT order_id) AS Average_Order_Value FROM pizza_sales;

# Total pizzas sold

SELECT SUM(quantity) as Total_pizza_sold FROM pizza_sales;

# Total  orders

SELECT COUNT( DISTINCT order_id ) as Total_orders FROM pizza_sales;

#Average pizzas per order

SELECT SUM(quantity)/COUNT(DISTINCT order_id) AS avg_pizzas_per_order FROM pizza_sales;

# 2 charts  requirement

# daily trend for total orders

SELECT 
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_day
ORDER BY FIELD(order_day,
               'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

# Hourly Trend for total orders

SELECT hour(order_time) AS order_hour,
 COUNT(DISTINCT order_id) AS total_orders
 FROM pizza_sales
 GROUP BY order_hour
 ORDER BY order_hour;
 
 # percentage of sales by pizza category
SELECT pizza_category,SUM(total_price) AS  total_sales, SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) AS pct
FROM pizza_sales  
GROUP BY pizza_category;

# Percentage of sales by pizza size
SELECT 
    pizza_size,
    CAST(SUM(total_price)  AS DECIMAL(10,2)) AS total_sales,
    CAST(SUM(total_price) * 100 /
        (SELECT SUM(total_price) FROM pizza_sales
        WHERE MONTH(order_date) IN (1,2,3))  AS DECIMAL(10,2)
    ) AS pct
FROM pizza_sales  
WHERE MONTH(order_date) IN (1,2,3)
GROUP BY pizza_size
ORDER BY pct DESC;


# Total pizza sold by pizza category

SELECT pizza_category , SUM(quantity) AS Total_pizza_sold From pizza_sales
GROUP BY pizza_category;

# Top 5 best sellers by total prize

SELECT pizza_name,SUM(quantity) AS Total_pizzas_sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity)
LIMIT 5;

#  Botton  5  sellers by total prize
SELECT pizza_name,SUM(quantity) AS Total_pizzas_sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 5;