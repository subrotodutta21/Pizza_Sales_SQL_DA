# SQL - Pizza Sales Analysis 
![PIZZA SALES SQL PROJECT](https://github.com/user-attachments/assets/4d38ba93-1535-463e-9713-b954dafe5a5c)

## Project Overview
The project involves querying a pizza sales database to derive key insights.
The queries leverage advanced SQL functions and techniques to analyze sales trends, pizza popularity, revenue distribution, and more.

## Database Schema 

![Screenshot 2024-08-28 200832](https://github.com/user-attachments/assets/c9d592fc-2034-4fa5-8f76-6116ebbfa766)

<br>
The database comprises the following tables:

- orders: Contains details about each order, including order_id, order_date, order_time, etc.
- order_details: Stores order specifics, such as order_id, pizza_id, quantity, etc.
- pizzas: Contains pizza-related information, including pizza_id, pizza_type_id, price, size, etc.
- pizza_types: Describes pizza types and categories, including pizza_type_id, name, category, etc.

## SQL Queries Overview

- Total Orders Calculation: Retrieves the total number of orders placed.
- Revenue Calculation: Calculates total revenue from pizza sales.
- Highest-Priced Pizza Identification: Finds the most expensive pizza available.
- Top Pizza Types Based on Quantity: Lists the most popular pizza types by quantity ordered.
- Revenue Contribution by Pizza Type: Calculates each pizza type's contribution to the overall revenue.
- Cumulative Revenue Over Time: Analyzes cumulative revenue generated over months.
- Top Pizza Types by Revenue for Each Category: Determines top pizza types based on revenue within each category.
- Average Orders Per Day Calculation: Computes the average number of pizzas ordered each day.

## Tools used 

- My SQL
  - Aggregate Functions
  - Joins
  - Window Functions
  - Subqueries
  - Date and Time Functions
  - Common Table Expressions (CTEs)
