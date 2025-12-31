-- CREATE DATABASE customer_retention_db;
 USE customer_retention_db;
-- CREATE TABLE customers(
-- customer_id INT PRIMARY KEY AUTO_INCREMENT,
-- customer_name VARCHAR(50),
-- signup_date DATE,
-- city VARCHAR(50)
-- );
-- CREATE TABLE orders(
-- order_id INT PRIMARY KEY AUTO_INCREMENT,
-- customer_id INT,
-- order_date DATE,
-- FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
-- );
-- CREATE TABLE products(
-- product_id INT PRIMARY KEY AUTO_INCREMENT,
-- product_name VARCHAR(50),
-- category VARCHAR(50),
-- price DECIMAL(10,2)
-- );
-- CREATE TABLE order_details(
-- order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
-- order_id INT,
-- product_id INT,
-- quantity INT,
-- FOREIGN KEY (order_id) REFERENCES orders(order_id),
-- FOREIGN KEY (product_id) REFERENCES products(product_id)
-- );
-- INSERT INTO customers VALUES
-- (1,'Divya','2023-11-10','Hyderabad'),
-- (2,'Ravi','2023-11-15','Bengaluru'),
-- (3,'Neha','2023-12-01','Chennai'),
-- (4,'Kiran','2023-12-05','Pune'),
-- (5,'Meena','2023-12-20','Hyderabad'),
-- (6,'Arjun','2024-01-02','Bengaluru');
-- INSERT INTO orders VALUES
-- (1001,1,'2023-12-01'),
-- (1002,2,'2023-12-05'),
-- (1003,1,'2023-12-20'),
-- (1004,3,'2024-01-10'),
-- (1005,1,'2024-01-25'),
-- (1006,4,'2024-02-01'),
-- (1007,2,'2024-02-05'),
-- (1008,5,'2024-02-20');
-- INSERT INTO products VALUES
-- (201,'Smart Watch','Wearables',7000),
-- (202,'Wireless Earbuds','Audio',4000),
-- (203,'Phone Stand','Accessories',800),
-- (204,'Power Bank','Electronics',2500),
-- (205,'Laptop Sleeve','Lifestyle',1800);
-- INSERT INTO order_details VALUES
-- (1,1001,201,1),
-- (2,1001,203,1),
-- (3,1002,202,1),
-- (4,1003,203,2),
-- (5,1003,205,1),
-- (6,1004,204,1),
-- (7,1005,201,1),
-- (8,1005,202,1),
-- (9,1006,205,1),
-- (10,1007,203,1),
-- (11,1008,204,2);
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM order_details; 
-- SELECT c.customer_id,c.customer_name,COUNT(o.order_id) AS Total_Orders FROM customers c INNER JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id ,c.customer_name HAVING COUNT(o.order_id)=1;
-- SELECT c.customer_id,c.customer_name,COUNT(o.order_id) AS Total_Orders FROM customers c INNER JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id,c.customer_name HAVING COUNT(o.order_id)>1;
-- SELECT c.customer_id,c.customer_name,COUNT(o.order_id) AS Total_Orders FROM customers c INNER JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_id,c.customer_name ORDER BY Total_Orders DESC;
-- SELECT c.customer_name FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id WHERE o.order_id IS NULL;
-- SELECT AVG(order_value) AS avg_order_value FROM(SELECT o.order_id,SUM(p.price*od.quantity) AS order_value FROM order_details od INNER JOIN orders o ON od.order_id=o.order_id INNER JOIN products p ON od.product_id=p.product_id GROUP BY o.order_id)t;
-- SELECT order_id,order_value
-- FROM(
-- SELECT o.order_id,SUM(p.price*od.quantity) AS order_value
-- FROM order_details od INNER JOIN orders o 
-- ON od.order_id=o.order_id
-- INNER JOIN products p ON
-- od.product_id=p.product_id
-- GROUP BY o.order_id)t
-- WHERE order_value>(
-- SELECT AVG(order_value) FROM(
-- SELECT o.order_id,SUM(p.price*od.quantity) AS order_value 
-- FROM order_details od INNER JOIN orders o 
-- ON od.order_id=o.order_id
-- INNER JOIN products p 
-- ON od.product_id=p.product_id
-- GROUP BY o.order_id)x
-- )ORDER BY order_value ASC;
SELECT c.customer_name,COUNT( DISTINCT o.order_id) AS Total_Orders,SUM(p.price*od.quantity) AS Total_Revenue 
FROM customers c INNER JOIN orders o 
ON c.customer_id=o.customer_id INNER JOIN order_details od 
ON od.order_id=o.order_id INNER JOIN products p 
ON p.product_id=od.product_id GROUP BY c.customer_name HAVING COUNT(o.order_id)>1 AND SUM(p.price*od.quantity)=(SELECT MAX(customer_revenue) FROM (SELECT SUM(p.price*od.quantity) AS Customer_Revenue FROM order_details od INNER JOIN products p ON od.product_id=p.product_id INNER JOIN orders o ON od.order_id=o.order_id GROUP BY o.customer_id)t);
SELECT c.customer_name,MIN(o.order_date) AS First_Order_Date,MAX(o.order_date) AS Last_Order_Date FROM customers c INNER JOIN orders o ON c.customer_id=o.customer_id GROUP BY c.customer_name;
SELECT DISTINCT(p.product_name) FROM products p INNER JOIN order_details od ON p.product_id=od.product_id INNER JOIN orders o ON od.order_id=o.order_id WHERE o.customer_id IN(SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(order_id)>1);
SELECT p.product_name FROM products p LEFT JOIN order_details od ON p.product_id=od.product_id  WHERE od.product_id IS NULL;
