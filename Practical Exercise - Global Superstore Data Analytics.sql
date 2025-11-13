use indexing;
SELECT * FROM SUPERSTORE;

-- 1. Find Total Revenue, quantities and profit generated.
select round(sum(quantity * `Shipping Cost`),2) as total_revenue,
sum(quantity) as Quantities,
round(sum(Profit),2) from superstore;

-- 2. Find Segment wise distribution of the sales
select segment, round(sum(sales),2) as Distributed_sales from superstore
group by segment
order by Distributed_sales desc;

-- 3. Find the top 3 most profitable products.
select `Product Name`, Profit from superstore
limit 3;

-- 4. how many orders are placed after january 2016.
select count(*) as Placed_Jan_2016 from superstore
where `order date` > '31-01-2016';

-- 5. How many states from Australia are under the root of business.
select count(*) as State_Count from superstore
where country = "Australia";

-- 6. Which products and subcategories are most and least profitable?
SELECT 
    t.`Product Name`,
    t.`sub-category`,
    t.total_profit
FROM (
SELECT `Product Name`, `sub-category`, round(SUM(profit),2) AS total_profit FROM superstore
GROUP BY `Product Name`, `sub-category`
) AS t
WHERE 
t.total_profit = (SELECT round(MAX(total_profit),2) FROM (SELECT SUM(profit) AS total_profit FROM superstore
GROUP BY `Product Name`, `sub-category`
) AS maxq)
OR
t.total_profit = (SELECT round(MIN(total_profit),2) FROM (SELECT SUM(profit) AS total_profit FROM superstore
GROUP BY `Product Name`, `sub-category`
) AS minq);

-- 7. Which customer segment contributes the most to the total revenue?
select segment, round(sum(quantity * `shipping cost`),2) as Total_Revenue from superstore
group by segment
order by Total_Revenue desc;

-- 8. what is the year-over-year growth in sales and profit?
SELECT round(SUM(Sales),2) AS total_sales, round(SUM(Profit),2) AS total_profit FROM superstore;

-- 9. Which countries and cities are driving the highest sales
select country, city, round(sum(quantity * `shipping cost`),2) as Total_Sales from superstore
group by country, city
order by Total_Sales desc;

-- 10. What is the average delivery time from order to ship date across regions?
select region, round(avg(`Ship Date` - `Order Date`),2) as Avg_Delivery_Time from superstore
group by region
order by region;

-- 11. What is the profit distribution across order priority?
SELECT `Order Priority`, round(SUM(Profit),2) AS total_profit FROM superstore
GROUP BY `Order Priority`
ORDER BY total_profit DESC;

-- 12. Suggest data-driven recommendations for improving profit and reducing losses.
SELECT Discount, round(AVG(Profit),2) FROM superstore 
GROUP BY Discount;
