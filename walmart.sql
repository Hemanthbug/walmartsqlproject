SELECT * FROM saleDataWalmart.Sales;

select time,
	(case
     when `time` between "00:00:00" and "12:00:00" then "morning"
	 when `time` between "12:01:00" and "16:00:00" then "Afternoon"
     else "Evening"
     end
     ) as time_of_day
 from Sales;
 
 alter table Sales add column time_of_day varchar(20);

update Sales
set time_of_day = (
case
     when `time` between "00:00:00" and "12:00:00" then "morning"
	 when `time` between "12:01:00" and "16:00:00" then "Afternoon"
     else "Evening"
end
);

-- --day_name

select date,
dayname(date) as day_name
from Sales;

alter table Sales add column day_name varchar(10);

update Sales 
set day_name = dayname(date);

-- -month_name

select date,
monthname(date)as month_name
from Sales;

alter table Sales add column month_name varchar(10);

update Sales
set month_name = monthname(date);

-- How many unique cities does the data have?
alter table Sales rename COLUMN ciry TO city;
select 
distinct city
from Sales;


-- In which city is each branch?

select 
distinct branch
from Sales;

select 
distinct city, branch
from Sales;
	
-- How many unique product lines does the data have?

select count(distinct product_line)
from Sales;
-- what is the most common payment method?

select payment_method,
count(payment_method)as cnt
from Sales 
group by payment_method
order by cnt desc;

-- what is the most selling product_line?

select product_line, count(product_line)as sale from Sales group by product_line order by sale desc;

-- What is the total revenue by month?
SELECT
month_name AS month,
SUM(total) AS total_revenue
FROM Sales
GROUP BY month_name
ORDER BY total_revenue desc;

-- What month had the largest COGS?
select 
month_name as month,
sum(cogs) as total_cogs
from Sales
group by month_name
order by total_cogs desc;
-- What product line had the largest revenue?
select 
product_line,
sum(total) as total_revenue
from Sales
group by product_line
order by total_revenue desc;

-- which city has the largest revenue;
select
city,branch,
sum(total) as total_revenue
from Sales
group by city,branch
order by total_revenue desc;

-- Which branch sold more products than average product sold?
select 
branch,
sum(quantity) 
from Sales
group by branch
having sum(quantity)>(select avg(quantity)from Sales);


-- -Number of sales made in each time of the day per weekday
select 
time_of_day,
count(*) as total_sales
from Sales
where day_name = "Sunday"
group by time_of_day
order by total_sales;

-- -Which time of the day do customers give most ratings?

select 
time_of_day,
avg(rating) as avg_rating
from Sales
group by time_of_day
order by avg_rating;
     