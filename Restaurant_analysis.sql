use restaurant_db;

-- Menu Table Exploration


-- 1. view the menu_items table.
SELECT 
    *
FROM
    menu_items;

-- 2. Find the number of items on the menu.
SELECT 
    COUNT(menu_item_id)
FROM
    menu_items;

-- 3. What are the least and most expensive items in the menu?
SELECT 
    *
FROM
    menu_items
ORDER BY price DESC;

-- 4. How many italian dishes are on the menu.

SELECT 
    COUNT(*)
FROM
    menu_items
WHERE
    category = 'italian';

-- 5. what are the least and most expensive italian dishes in the menu?
SELECT 
    *
FROM
    menu_items
WHERE
    category = 'italian'
ORDER BY price DESC;

-- 6. How many dishes are in each category?
SELECT 
    category, COUNT(category)
FROM
    menu_items
GROUP BY category
ORDER BY category DESC;

-- 7. what is the average dish price within each category?
SELECT 
    category, AVG(price) AS avg_price
FROM
    menu_items
GROUP BY category
ORDER BY avg_price DESC;


-- Orders Table Exploration

-- 1. View the order_details table.
SELECT 
    *
FROM
    order_details;

-- 2. What is the date range of the table?
SELECT 
    *
FROM
    order_details
ORDER BY order_date;

-- 3. How many orders were made wihtin this date range?
SELECT 
    COUNT(DISTINCT order_id)
FROM
    order_details;

-- 4. How many items were ordered within this date range?
SELECT 
    COUNT(*)
FROM
    order_details;

-- 5. Which orders had the most number of items?
SELECT 
    order_id, COUNT(item_id) AS num_items
FROM
    order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 6. How many orders had more than 12 items?
SELECT 
    COUNT(*)
FROM
    (SELECT 
        order_id, COUNT(item_id) AS num_items
    FROM
        order_details
    GROUP BY order_id
    HAVING num_items > 12) AS num_orders
    ;
    
    

-- Customer Behaviour Analysis

-- 1. Combine the menu items and order items into a single table.
 SELECT 
    *
FROM
    menu_items;
 SELECT 
    *
FROM
    order_details;
 
 -- Joining menu_table and order_details table
 
 SELECT 
    *
FROM
    order_details od
        LEFT JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
;

-- 2. What were the least and most ordered items? What categories were they in?

SELECT 
    item_name, category, COUNT(order_details_id) AS num_purchase
FROM
    order_details od
        LEFT JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name , category
ORDER BY num_purchase DESC;
 
-- 3. What were the top 5 orders that spent the most money?

SELECT 
    order_id, SUM(price) AS total_spend
FROM
    order_details od
        LEFT JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- 4. View the details of the highest spend order. What insights can you gather from the result?
SELECT 
    category, COUNT(item_id)
FROM
    order_details od
        LEFT JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
WHERE
    order_id = 440
GROUP BY category;
 
-- 5. View the details of the top 5 highest spend orders. What insights can you gather from the results?
SELECT 
    order_id, category, COUNT(item_id) AS num_items
FROM
    order_details od
        LEFT JOIN
    menu_items mi ON od.item_id = mi.menu_item_id
WHERE
    order_id IN (440 , 2075, 1957, 330, 2675)
GROUP BY order_id , category;
 

 










