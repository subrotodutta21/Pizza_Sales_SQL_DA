/*
1. Retrive total number of orders 
*/

SELECT 
COUNT(order_id) AS Total_orders
FROM orders;

/* 
2. Calculate the total revenue generated from pizza sales.
*/

SELECT
ROUND(SUM(order_details.quantity*pizzas.price),2) AS Total_revenue
FROM order_details
LEFT JOIN pizzas
USING (pizza_id);

/* 
3. Identify the highest-priced pizza.
*/

SELECT 
pizza_types.name AS Highest_priced_pizza,
pizzas.price AS Price
FROM pizzas
LEFT JOIN pizza_types
USING (pizza_type_id)
ORDER BY 2 DESC
LIMIT 1;

/*
4. Identify the most common pizza size ordered.
*/

SELECT
pizzas.size AS Pizza_size,
SUM(order_details.quantity) AS Quantity_ordered
FROM order_details
LEFT JOIN pizzas
USING (pizza_id)
GROUP BY 1
ORDER BY  2 DESC
LIMIT 1;


/*
5. List the top 5 most ordered pizza types along with their quantities ordered.
*/

SELECT
pizza_types.name AS Pizza_name,
SUM(order_details.quantity) AS Quantity_ordered
FROM order_details
LEFT JOIN pizzas
USING (pizza_id)
LEFT JOIN pizza_types
USING (pizza_type_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

/*
6. Find the total quantity of each pizza category ordered.
*/

SELECT
pizza_types.category AS Pizza_category,
SUM(order_details.quantity) AS Quantity_ordered
FROM order_details
LEFT JOIN pizzas
USING (pizza_id)
LEFT JOIN pizza_types
USING (pizza_type_id)
GROUP BY 1
ORDER BY 2 DESC;

/*
7. Determine the distribution of orders by hour of the day.
*/

SELECT
HOUR(order_time) AS Time,
COUNT(order_id) AS Total_orders
FROM orders
GROUP BY 1 
ORDER BY 1;

/*
8. Find out the category-wise distribution of pizzas.
*/

SELECT
category AS Pizza_category,
COUNT(name) AS  category_distribution
FROM pizza_types
GROUP BY 1
ORDER BY 2 DESC;

/*
9. Calculate the average number of pizzas ordered per day.
*/

SELECT
ROUND(AVG(quantity)) AS Avg_orders_per_day	
FROM(
SELECT 
orders.order_date,
SUM(order_details.quantity) AS quantity
FROM order_details
LEFT JOIN orders
USING (order_id)
GROUP BY 1) AS Table_1;

/*
10. Determine the top 3 most ordered pizzas based on revenue.
*/

SELECT 
pizza_types.name AS Pizza_name,
ROUND(SUM(pizzas.price*order_details.quantity),2) AS Total_revenue
FROM order_details
LEFT JOIN pizzas
USING (pizza_id)
LEFT JOIN pizza_types
USING (pizza_type_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

/*
11. Calculate the percentage contribution of each pizza type to total revenue.
*/

SELECT pizza_types.category AS Pizza_category,
CONCAT(ROUND(SUM(pizzas.price*order_details.quantity)*100/
(SELECT SUM(pizzas.price*order_details.quantity)
 FROM pizzas 
 LEFT JOIN order_details 
 USING (pizza_id)),2), '%') AS Percent_of_total_revenue
FROM 
order_details
LEFT JOIN pizzas
USING (pizza_id) 
LEFT JOIN pizza_types
USING (pizza_type_id)
GROUP BY 1
ORDER BY 2 DESC;

/*
12. Analyze the cumulative revenue generated over time for each month.
*/

SELECT
M AS Month,
Monthly_revenue,
ROUND(SUM(Monthly_revenue) OVER (order by M),2)as Cumulative_Revenue
FROM(
SELECT
MONTH(orders.order_date) AS M,
ROUND(SUM(order_details.quantity*pizzas.price),2) AS Monthly_revenue
FROM orders
LEFT JOIN order_details
USING (order_id)
LEFT JOIN pizzas
USING (pizza_id)
GROUP by 1) AS Table_1
GROUP BY 1
ORDER BY 1;


/*
13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
*/

WITH PizzaRevenue AS (
SELECT
pizza_types.category AS Category,
pizza_types.name AS Name,
ROUND(SUM(order_details.quantity * pizzas.price), 2) AS Total_revenue
FROM pizza_types
LEFT JOIN pizzas USING (pizza_type_id)
LEFT JOIN order_details USING (pizza_id)
GROUP BY 1,2
),
RankedPizzas AS (
SELECT
Category,
Name,
Total_revenue,
RANK() OVER (PARTITION BY Category ORDER BY Total_revenue DESC) AS Rank_
FROM PizzaRevenue
)
SELECT
Rank_,
Category AS Pizza_category,
Name AS Pizza_name,
Total_revenue
FROM RankedPizzas
WHERE Rank_ <= 3;