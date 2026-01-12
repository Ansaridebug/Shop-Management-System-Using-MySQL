create database cake_m;
use cake_m;

# 1. Customers ↔ Orders
#Relationship: One-to-Many (1 : M)
#One customer can place many orders
#One order belongs to only one customer

# 2. Orders ↔ Order_Items
#Relationship: One-to-Many (1 : M)
#One order can contain many order items
#Each order item belongs to one order

# 3. Cakes ↔ Order_Items
#Relationship: One-to-Many (1 : M)
#One cake can appear in many order items
#Each order item refers to one cake

# 4. Orders ↔ Cakes
#Relationship: Many-to-Many (M : M)

create table customers (
    customer_id INT PRIMARY KEY,
    Cname VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT
);
desc customers;

INSERT INTO customers VALUES
(1, 'Aarav Sharma', '9876543210', 'aarav@gmail.com', 'Mumbai'),
(2, 'Ananya Verma', '9876543211', 'ananya@gmail.com', 'Delhi'),
(3, 'Rohit Mehta', '9876543212', 'rohit@gmail.com', 'Ahmedabad'),
(4, 'Priya Singh', '9876543213', 'priya@gmail.com', 'Lucknow'),
(5, 'Karan Patel', '9876543214', 'karan@gmail.com', 'Surat'),
(6, 'Sneha Iyer', '9876543215', 'sneha@gmail.com', 'Chennai'),
(7, 'Rahul Gupta', '9876543216', 'rahul@gmail.com', 'Kanpur'),
(8, 'Neha Joshi', '9876543217', 'neha@gmail.com', 'Pune'),
(9, 'Amit Kumar', '9876543218', 'amit@gmail.com', 'Patna'),
(10, 'Pooja Nair', '9876543219', 'pooja@gmail.com', 'Kochi'),
(11, 'Vikram Malhotra', '9876543220', 'vikram@gmail.com', 'Delhi'),
(12, 'Ritu Saxena', '9876543221', 'ritu@gmail.com', 'Jaipur'),
(13, 'Sahil Khan', '9876543222', 'sahil@gmail.com', 'Bhopal'),
(14, 'Meena Reddy', '9876543223', 'meena@gmail.com', 'Hyderabad'),
(15, 'Nitin Agarwal', '9876543224', 'nitin@gmail.com', 'Agra'),
(16, 'Kavya Mishra', '9876543225', 'kavya@gmail.com', 'Varanasi'),
(17, 'Arjun Das', '9876543226', 'arjun@gmail.com', 'Kolkata'),
(18, 'Simran Kaur', '9876543227', 'simran@gmail.com', 'Amritsar'),
(19, 'Manish Yadav', '9876543228', 'manish@gmail.com', 'Gurgaon'),
(20, 'Ishita Choudhary', '9876543229', 'ishita@gmail.com', 'Noida');
select*from customers ;

CREATE TABLE cakes (
    cake_id INT PRIMARY KEY,
    cake_name VARCHAR(30),
    flavor VARCHAR(50),
    price int,
    weight VARCHAR(20),
    availability BOOLEAN DEFAULT TRUE
);
desc cakes;

INSERT INTO cakes VALUES
(1, 'Chocolate Truffle', 'Chocolate', 600, '1 kg', TRUE),
(2, 'Black Forest', 'Chocolate', 550, '1 kg', TRUE),
(3, 'Red Velvet', 'Vanilla', 650, '1 kg', TRUE),
(4, 'Butterscotch', 'Butterscotch', 500, '1 kg', TRUE),
(5, 'Pineapple', 'Pineapple', 450, '1 kg', TRUE),
(6, 'Vanilla Cream', 'Vanilla', 400, '1 kg', TRUE),
(7, 'Strawberry', 'Strawberry', 480, '1 kg', TRUE),
(8, 'Mango Delight', 'Mango', 520, '1 kg', TRUE),
(9, 'Blueberry', 'Blueberry', 700, '1 kg', TRUE),
(10, 'Coffee Mocha', 'Coffee', 600, '1 kg', TRUE),
(11, 'KitKat Cake', 'Chocolate', 750, '1 kg', TRUE),
(12, 'Oreo Cake', 'Chocolate', 720, '1 kg', TRUE),
(13, 'Ferrero Rocher', 'Chocolate', 900, '1 kg', TRUE),
(14, 'White Forest', 'Vanilla', 580, '1 kg', TRUE),
(15, 'Fruit Cake', 'Mixed Fruit', 500, '1 kg', TRUE),
(16, 'Chocolate Lava', 'Chocolate', 650, '0.5 kg', TRUE),
(17, 'Rainbow Cake', 'Vanilla', 800, '1 kg', TRUE),
(18, 'Caramel Crunch', 'Caramel', 620, '1 kg', TRUE),
(19, 'Almond Cake', 'Dry Fruit', 700, '1 kg', TRUE),
(20, 'Cheese Cake', 'Cheese', 850, '1 kg', TRUE);
select * from cakes;

set sql_safe_updates=0;

#Step 1: Temporarily disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

#Step 2: Update cakes table (1–20 ➜ 21–40)
UPDATE cakes
SET cake_id = cake_id + 20;

#Step 3: Update order_items table to match new cake IDs
UPDATE order_items
SET cake_id = cake_id + 20;

#Step 4: Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

#Verify the changes
SELECT cake_id, cake_name FROM cakes;

SELECT order_item_id, cake_id FROM order_items;

# Here is an example of changing the weight for a few cake records using UPDATE statements 
UPDATE cakes SET weight = '1.5 kg' WHERE cake_id IN (2, 9, 13);

UPDATE cakes SET weight = '2 kg' WHERE cake_id IN (11, 17, 20);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
desc orders;

INSERT INTO orders VALUES
(101, 1, '2024-01-05', 1200.00, 'Delivered'),
(102, 2, '2024-01-06', 550.00, 'Delivered'),
(103, 3, '2024-01-07', 650.00, 'Delivered'),
(104, 4, '2024-01-08', 1000.00, 'Delivered'),
(105, 5, '2024-01-09', 450.00, 'Delivered'),
(106, 6, '2024-01-10', 800.00, 'Delivered'),
(107, 7, '2024-01-11', 480.00, 'Delivered'),
(108, 8, '2024-01-12', 700.00, 'Delivered'),
(109, 9, '2024-01-13', 600.00, 'Delivered'),
(110, 10, '2024-01-14', 850.00, 'Delivered'),
(111, 11, '2024-01-15', 750.00, 'Delivered'),
(112, 12, '2024-01-16', 580.00, 'Delivered'),
(113, 13, '2024-01-17', 900.00, 'Delivered'),
(114, 14, '2024-01-18', 520.00, 'Delivered'),
(115, 15, '2024-01-19', 500.00, 'Delivered'),
(116, 16, '2024-01-20', 650.00, 'Delivered'),
(117, 17, '2024-01-21', 800.00, 'Delivered'),
(118, 18, '2024-01-22', 620.00, 'Delivered'),
(119, 19, '2024-01-23', 700.00, 'Delivered'),
(120, 20, '2024-01-24', 850.00, 'Delivered');
select*from orders;

# Update Order Status (change from Delivered)
UPDATE orders
SET order_status = 'Pending'
WHERE order_id IN (105, 110, 115);

UPDATE orders
SET order_status = 'Cancelled'
WHERE order_id IN (108, 118);

UPDATE orders
SET order_status = 'Confirmed'
WHERE order_id IN (112, 117);

UPDATE orders
SET customer_id = 3
WHERE order_id = 105;

UPDATE orders
SET customer_id = 7
WHERE order_id = 110;

UPDATE orders
SET customer_id = 12
WHERE order_id = 118;

SELECT order_id, customer_id, order_status
FROM orders;

# 1 Insight
# First, find duplicate customer IDs
# (This shows customers who have more than one order)

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    cake_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (cake_id) REFERENCES cakes(cake_id)
);
desc order_items;

INSERT INTO order_items VALUES
(1, 101, 1, 2, 1200.00),(2, 102, 2, 1, 550.00),
(3, 103, 3, 1, 650.00),(4, 104, 4, 2, 1000.00),
(5, 105, 5, 1, 450.00),(6, 106, 6, 2, 800.00),
(7, 107, 7, 1, 480.00),(8, 108, 8, 1, 520.00),
(9, 109, 9, 1, 700.00),(10, 110, 10, 1, 600.00),
(11, 111, 11, 1, 750.00),(12, 112, 12, 1, 720.00),
(13, 113, 13, 1, 900.00),(14, 114, 14, 1, 580.00),
(15, 115, 15, 1, 500.00),(16, 116, 16, 1, 650.00),
(17, 117, 17, 1, 800.00),(18, 118, 18, 1, 620.00),
(19, 119, 19, 1, 700.00),(20, 120, 20, 1, 850.00);
select*from order_items;

#Update order_item_id to range 1021–1040
UPDATE order_items
SET order_item_id = order_item_id + 1020;

# Verify after update
SELECT order_item_id, order_id, cake_id
FROM order_items
ORDER BY order_item_id;

