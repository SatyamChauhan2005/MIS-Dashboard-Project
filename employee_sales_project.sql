-- Employee & Sales Management Project in MySQL

CREATE DATABASE IF NOT EXISTS employee_sales_db;
USE employee_sales_db;

-- Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(30),
    hire_date DATE
);

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(30),
    join_date DATE
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    product VARCHAR(30),
    amount DECIMAL(10,2),
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Sample Queries

-- 1. Total sales by product
SELECT product, SUM(amount) AS total_sales
FROM sales
GROUP BY product
ORDER BY total_sales DESC;

-- 2. Top 5 employees by sales
SELECT e.name, SUM(s.amount) AS employee_sales
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
GROUP BY e.name
ORDER BY employee_sales DESC
LIMIT 5;

-- 3. Monthly revenue
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month, SUM(amount) AS revenue
FROM sales
GROUP BY month
ORDER BY month;

-- 4. Customer purchase count
SELECT c.name, COUNT(s.sale_id) AS purchases
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.name
ORDER BY purchases DESC;

-- 5. Employee-wise customer handling
SELECT e.name AS employee, c.name AS customer, COUNT(s.sale_id) AS total_sales
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY e.name, c.name
ORDER BY e.name;
