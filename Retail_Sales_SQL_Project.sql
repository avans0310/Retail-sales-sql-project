USE retail_sales_project;

-- ==========================
-- 1. CUSTOMERS TABLE
-- ==========================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50),
    state_name VARCHAR(50),
    registration_date DATE
);

-- ==========================
-- 2. CATEGORIES TABLE
-- ==========================

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);

-- ==========================
-- 3. PRODUCTS TABLE
-- ==========================

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,

    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);

-- ==========================
-- 4. ORDERS TABLE
-- ==========================

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

-- ==========================
-- 5. ORDER ITEMS TABLE
-- ==========================

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);

-- ==========================
-- 6. PAYMENTS TABLE
-- ==========================

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    payment_date DATE,

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);
SHOW TABLES;
DESC customers;
DESC products;
DESC orders;
USE retail_sales_project;

INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Home & Kitchen'),
('Sports'),
('Beauty'),
('Books');
SELECT * FROM categories;
INSERT INTO products
(product_name, category_id, price, stock_quantity)
VALUES
('iPhone 15',1,79999,50),
('Samsung TV',1,65000,20),
('Bluetooth Speaker',1,3000,120),

('Men T-Shirt',2,799,200),
('Women Kurti',2,1499,150),
('Jeans',2,1999,180),

('Mixer Grinder',3,4500,60),
('Rice Cooker',3,5500,45),
('Dining Table',3,12000,20),

('Cricket Bat',4,3500,80),
('Football',4,1200,100),

('Face Wash',5,299,300),
('Perfume',5,1499,100),

('SQL Learning Book',6,899,70),
('Python Basics Book',6,999,65);
SELECT * FROM products;
INSERT INTO customers
(first_name,last_name,gender,age,city,state_name,registration_date)
VALUES
('Anirudh','S','Male',25,'Madurai','Tamil Nadu','2025-01-15'),
('Rahul','Kumar','Male',29,'Chennai','Tamil Nadu','2025-02-10'),
('Priya','Sharma','Female',27,'Bangalore','Karnataka','2025-01-20'),
('Karthik','R','Male',31,'Coimbatore','Tamil Nadu','2025-03-05'),
('Aishwarya','M','Female',24,'Hyderabad','Telangana','2025-02-22'),
('Vikram','Singh','Male',35,'Mumbai','Maharashtra','2025-01-30'),
('Sneha','Patel','Female',28,'Pune','Maharashtra','2025-04-01'),
('Arjun','Das','Male',26,'Delhi','Delhi','2025-03-10'),
('Meena','K','Female',30,'Trichy','Tamil Nadu','2025-02-18'),
('Ravi','Verma','Male',33,'Kolkata','West Bengal','2025-01-11');
SELECT * FROM customers;
INSERT INTO orders
(customer_id,order_date,order_status)
VALUES
(1,'2025-05-01','Delivered'),
(2,'2025-05-03','Delivered'),
(3,'2025-05-04','Cancelled'),
(4,'2025-05-07','Delivered'),
(5,'2025-05-08','Pending'),
(6,'2025-05-09','Delivered'),
(7,'2025-05-10','Delivered'),
(8,'2025-05-11','Returned'),
(9,'2025-05-12','Delivered'),
(10,'2025-05-13','Delivered');
SELECT * FROM orders;

INSERT INTO order_items
(order_id,product_id,quantity,total_price)
VALUES
(1,1,1,79999),
(1,4,2,1598),

(2,2,1,65000),

(3,5,1,1499),

(4,10,1,3500),
(4,11,2,2400),

(5,7,1,4500),

(6,8,1,5500),

(7,13,1,1499),

(8,14,2,1798),

(9,3,1,3000),

(10,15,1,999);
SELECT * FROM order_items;

INSERT INTO payments
(order_id,payment_method,payment_status,payment_date)
VALUES
(1,'UPI','Paid','2025-05-01'),
(2,'Credit Card','Paid','2025-05-03'),
(3,'UPI','Refunded','2025-05-04'),
(4,'Debit Card','Paid','2025-05-07'),
(5,'Cash on Delivery','Pending','2025-05-08'),
(6,'UPI','Paid','2025-05-09'),
(7,'Credit Card','Paid','2025-05-10'),
(8,'UPI','Refunded','2025-05-11'),
(9,'Debit Card','Paid','2025-05-12'),
(10,'UPI','Paid','2025-05-13');
SELECT * FROM payments;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payments;

SELECT
c.first_name,
o.order_id,
p.product_name,
oi.quantity,
oi.total_price
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id;

SELECT
SUM(total_price) AS total_revenue
FROM order_items;

SELECT
COUNT(*) AS total_customers
FROM customers;

SELECT
COUNT(*) AS total_orders
FROM orders;

SELECT
p.product_name,
SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

SELECT
p.product_name,
SUM(oi.total_price) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 1;

SELECT
c.first_name,
SUM(oi.total_price) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.first_name
ORDER BY total_spent DESC;

SELECT
order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

SELECT
cat.category_name,
SUM(oi.total_price) AS revenue
FROM categories cat
JOIN products p
ON cat.category_id = p.category_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY cat.category_name
ORDER BY revenue DESC;

SELECT
AVG(customer_spending) AS avg_customer_spending
FROM
(
SELECT
c.customer_id,
SUM(oi.total_price) AS customer_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id
) x;

SELECT
c.first_name,
SUM(oi.total_price) AS spent_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.first_name
HAVING SUM(oi.total_price) > 5000
ORDER BY spent_amount DESC;

SELECT
payment_method,
COUNT(*) AS total_payments
FROM payments
GROUP BY payment_method;

SELECT
MONTH(order_date) AS month_number,
SUM(oi.total_price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY MONTH(order_date)
ORDER BY month_number;

SELECT
c.first_name,
SUM(oi.total_price) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.first_name
ORDER BY total_spent DESC
LIMIT 3;

SELECT
p.product_name
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

SELECT
first_name,
total_spent,
RANK() OVER(ORDER BY total_spent DESC) AS customer_rank
FROM
(
SELECT
c.first_name,
SUM(oi.total_price) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.first_name
) x;

SELECT
product_name,
price,
ROW_NUMBER() OVER
(ORDER BY price DESC) AS row_num
FROM products;

SELECT
cat.category_name,
COUNT(p.product_id) AS total_products
FROM categories cat
JOIN products p
ON cat.category_id = p.category_id
GROUP BY cat.category_name;

SELECT
MAX(total_price) AS highest_order_value
FROM order_items;

SELECT
MIN(total_price) AS lowest_order_value
FROM order_items;

SELECT
COUNT(DISTINCT c.customer_id) AS total_customers,
COUNT(DISTINCT o.order_id) AS total_orders,
SUM(oi.total_price) AS total_revenue,
ROUND(AVG(oi.total_price),2) AS avg_order_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id;

WITH customer_sales AS
(
SELECT
c.customer_id,
c.first_name,
SUM(oi.total_price) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id,c.first_name
)

SELECT *
FROM customer_sales
ORDER BY total_spent DESC;

CREATE VIEW sales_report AS
SELECT
c.first_name,
o.order_id,
o.order_date,
p.product_name,
oi.quantity,
oi.total_price,
pay.payment_method
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
JOIN payments pay
ON o.order_id = pay.order_id;

SELECT * FROM sales_report;

CREATE VIEW category_revenue AS
SELECT
cat.category_name,
SUM(oi.total_price) AS revenue
FROM categories cat
JOIN products p
ON cat.category_id = p.category_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY cat.category_name;

SELECT * FROM category_revenue;

DELIMITER $$

CREATE PROCEDURE GetCustomerOrders()
BEGIN

SELECT
c.first_name,
o.order_id,
o.order_date,
o.order_status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

END $$

DELIMITER ;

CALL GetCustomerOrders();

CREATE INDEX idx_customer_id
ON orders(customer_id);

CREATE INDEX idx_product_id
ON order_items(product_id);

SHOW FULL TABLES
WHERE Table_type='VIEW';

SHOW PROCEDURE STATUS
WHERE db = 'retail_sales_project';

SHOW TABLES;

SELECT
COUNT(DISTINCT c.customer_id) AS total_customers,
COUNT(DISTINCT o.order_id) AS total_orders,
SUM(oi.total_price) AS total_revenue,
ROUND(AVG(oi.total_price),2) AS avg_order_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id;

SELECT
c.first_name,
o.order_id,
p.product_name,
oi.quantity,
oi.total_price
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SHOW PROCEDURE STATUS
WHERE db = 'retail_sales_project';