# create database
use cake_m;
# 1. Total number of customers
select count(*) as total_customers from customers;

# 2. Total numbers of orders
select count(*) as total_orders from Orders;

# 3. Total sales amount
select sum(total_amount) as total_sales from Orders;

# 4. Customers who placed order
select distinct c.cname
from customers c
join Orders o on c.customer_id=o.customer_id;

# 5. Orders with status Pending
select*from orders where order_status='Pending';

# 6. Orders with status Cancelled
select*from orders where order_status='Cancelled';

# 7. Most expensive cake
select cake_name, price
from cakes
order by price desc
limit 1;

# 8. Cheapest cake
select cake_name, price
from cakes
order by price asc
limit 1;

# 9. Number of available cakes
select count(*) from cakes where availability= True;

# 10. Total quantity of cakes sold
select sum(quantity) as total_sold
from order_items;

# 11. Cake-wise total sales
select ck.cake_name, sum(oi.price) as total_sales
from cakes ck
join order_items oi on ck.cake_id=oi.cake_id
group by ck.cake_name;

# 12. Most popular cake (highest quantity sold) with price
select ck.cake_name, sum(oi.quantity) as qty_sold, ck.price
from cakes ck
join order_items oi on ck.cake_id=oi.cake_id
group by ck.cake_name,ck.price
order by qty_sold
limit 1;

# 13. Customer-wise total spending
select c.cname, sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id=o.customer_id
group by c.cname;

# 14. Customer who spent the most
select c.cname, sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id=o.customer_id
group by c.cname
order by total_spent desc
limit 1;

# 15. Orders placed on a specific date
select*from orders where order_date='2024-01-09';

# 16. Orders with more than one cake
select order_id, quantity
from order_items where quantity>1;

# 17. Orders with total amount greater than 800
select*from orders where total_amount>800;

# 18. Cake flavor-wise count
select flavor, count(*) as total
from cakes group by flavor;

# 19. Orders along with customer names
select o.order_id, c.cname, o.order_status
from orders o 
join customers c on o.customer_id=c.customer_id;

# 20. Complete order details (Customer + Cake)
select o.order_id, c.cname, ck.cake_name, oi.quantity, oi.price
from orders o 
join customers c on o.customer_id=c.customer_id
join order_items oi on o.order_id=oi.order_id
join cakes ck on oi.cake_id=ck.cake_id;

# 21. Which customer placed an order and what cake (product) they ordered 
# Customer → Order → Product Details
select c.cname as customer_name,o.order_id,ck.cake_name,ck.flavor,oi.price
from customers c
join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id
join cakes ck on oi.cake_id=ck.cake_id
order by c.cname;

# 22. Flavour-wise Cake Sold (Quantity)
select ck.flavor, sum(oi.quantity) as total_cake_sold
from cakes ck
join order_items oi 
on ck.cake_id=oi.cake_id
group by ck.flavor;
# Chocolate flavor cakes are the most sold, followed by Vanilla and Fruit flavors.

# 23. Flavour-wise Sales Amount (Revenue)
SELECT c.flavor, SUM(oi.price) AS total_sales_amount
FROM cakes c
JOIN order_items oi ON c.cake_id = oi.cake_id
GROUP BY c.flavor;

# 24. Cake-wise Total Sales & Quantity
select ck.cake_name,ck.price,
sum(oi.quantity) as total_qty_sold, 
sum(oi.price) as total_sales_amount
from cakes ck
join order_items oi on ck.cake_id=oi.cake_id
group by ck.cake_name,ck.price
order by total_sales_amount desc;

# 25. Row number partition by flavor
select*,row_number() over (partition by flavor) from cakes;

# 26. Flavor-wise sales with rank
select ck.flavor, sum(oi.price) as flavor_sales,
rank() over(order by sum(oi.price) desc) as flavor_rank
from cakes ck
join order_items oi on ck.cake_id=oi.cake_id
group by ck.flavor;
 
 # 27. Maximum and minimum cake price
 select max(price) as max_price, min(price) as min_price from cakes;
 
 # 28. Convert customer names to uppercase
 select upper(cname) as customer_name from customers;
 
 # 29. Concatenate cake name and flavor
 select concat(cake_name,' - ',flavor) as cake_delight from cakes;
 
 # 30. Length of customer names
 select cname, length(cname) as name_length from customers;
 
 # 31. Customers whose name starts with A
 select*from customers where cname like 'A%';
 
 # 32. Customers whose name contains an
 select*from customers where cname like '%an%';
 
 # 33. Cakes with Cake word in name
 select*from cakes where cake_name like '%Cake%';
 
 # 34. Cake name with second letter = o
 select*from cakes where cake_name like '_o%';
 
 # 35. Name with exactly 5 letters
 select*from customers where cname like '_____';
 
 # 36. Distinct cake names
 select distinct cake_name from cakes;
 
 # 37. Dense rank cakes by quantity sold
 select c.cake_name, sum(oi.quantity) as total_quantity,
dense_rank() over (order by sum(oi.quantity) desc) as quantity_rank
from cakes c
join order_items oi on c.cake_id = oi.cake_id
group by c.cake_name;

