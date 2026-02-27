select * from pizza_sales
--total_revenue
select SUM (total_price)AS total_revenue from pizza_sales

-- average_order_value       used ditinct   to take order id without duplicate  
select SUM (total_price) /COUNT (DISTINCT order_id) as average_order_value from pizza_sales 

-- pizza_sold
select sum (quantity) as pizza_sold from  pizza_sales
--  total_oder
select COUNT (distinct order_id) as total_oder from pizza_sales

select  cast (cast ( sum (quantity) as decimal(10,2))/ 
cast (COUNT (distinct order_id)  as decimal (10,2))   as decimal (10,2))  as total_pizza_order from pizza_sales
--daily trend
select DATENAME (dw,order_date ) as order_day , count(distinct order_id) as total_orders from pizza_sales
group by DATENAME (dw,order_date )

--hourly trend
select DATEPART (hour,order_time) as order_hours , count(distinct order_id) as total_orders from pizza_sales  
group by DATEPART (hour, order_time )

--percentage of  sales pizza by pizza  category
select pizza_category , sum (total_price) as total_prices ,
sum (total_price)*100 /   (select sum (total_price) from pizza_sales )   as total_sales  from pizza_sales 
group by  pizza_category 
 
 -- make a filter for one month 
 select pizza_category , sum (total_price) as total_prices ,
sum (total_price)*100 /   (select sum (total_price) from pizza_sales where month (order_date  )=1 )   as total_sales  from pizza_sales 
where MONTH (order_date ) =1
group by  pizza_category 


--percentage of  sales pizza by pizza_size
select pizza_size ,cast (sum (total_price) as decimal (10,2)) as total_price, cast(sum (total_price)*100 / 
( select sum(total_price)  from pizza_sales where DATEPART (QUARTER ,order_date) = 1)  as decimal (10,2)) as pct  from pizza_sales
where DATEPART (QUARTER ,order_date) = 1
group by pizza_size 


-- total_pizza soled by pizza_category
select * from pizza_sales 
select pizza_category , sum (quantity)  as total_pizza_sold from pizza_sales group by pizza_category 



-- top 5 sellers  by total_pizze_sold  
select  top 5 pizza_name  ,sum(quantity) as total_pizze_sold from pizza_sales
group by pizza_name  
order by sum(quantity) desc-- order by total_pizze_sold asc 

-- worst 5 sellers  by total_pizze_sold  with filter 
select  top 5 pizza_name  ,sum(quantity) as total_pizze_sold from pizza_sales

group by pizza_name  

order by sum(quantity) asc -- order by total_pizze_sold asc 






