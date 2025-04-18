
-- -----------------------------------------------------
-- 🧠 SQL Cheat Sheet Using sql_practice Schema
-- Target DBMS: MySQL
-- -----------------------------------------------------

-- 📌 Switch to or create the database
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- -----------------------------------------------------
-- 🟦 BASIC SELECT STATEMENTS
-- -----------------------------------------------------

-- Select all columns from the employees table
SELECT * FROM employees;

-- Select specific columns (name and salary) from employees
SELECT name, salary FROM employees;

-- -----------------------------------------------------
-- 🟩 FILTERING DATA (WHERE Clause)
-- -----------------------------------------------------

-- Find employees in department 2
SELECT * FROM employees WHERE dept_id = 2;

-- Find employees with salary above 50,000
SELECT * FROM employees WHERE salary > 5000;

-- Employees whose names start with 'A'
SELECT * FROM employees WHERE name LIKE 'A%';

-- Managers (employees who are listed as manager_id for others)
SELECT * FROM employees WHERE id IN (
    SELECT manager_id FROM employees WHERE manager_id IS NOT NULL
);

-- -----------------------------------------------------
-- 🟨 SORTING AND LIMITING RESULTS
-- -----------------------------------------------------

-- Top 5 highest paid employees
SELECT * FROM employees ORDER BY salary DESC LIMIT 5;

-- Skip first 3 rows and get next 2
SELECT * FROM employees ORDER BY id LIMIT 2 OFFSET 3;

-- -----------------------------------------------------
-- 🟧 JOINS (INNER, LEFT, SELF, MANY-TO-MANY)
-- -----------------------------------------------------

-- Inner Join: Employees with their department names
SELECT e.name, d.name AS department
FROM employees e
JOIN departments d ON e.dept_id = d.id;

-- Left Join: Include employees even if they have no department
SELECT e.name, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;

-- Many-to-Many: Employees and their assigned projects
SELECT e.name AS employee, p.name AS project
FROM employee_projects ep
JOIN employees e ON ep.employee_id = e.id
JOIN projects p ON ep.project_id = p.id;

-- Self Join: Employee with their manager's name
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- -----------------------------------------------------
-- 🟥 AGGREGATION AND GROUPING
-- -----------------------------------------------------

-- Sum of salaries by department
SELECT d.name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.dept_id = d.id
GROUP BY d.name;

-- Departments with more than 3 employees
SELECT dept_id, COUNT(*) AS total
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 3;

-- -----------------------------------------------------
-- 🟫 INSERT, UPDATE, DELETE
-- -----------------------------------------------------

-- Insert a new department
INSERT INTO departments (name) VALUES ('Legal');
select * from departments;

-- Increase salary by 10% for department 1
UPDATE employees SET salary = salary * 1.1 WHERE dept_id = 1;

-- Remove a specific employee from a project
DELETE FROM employee_projects WHERE employee_id = 1 AND project_id = 3;

-- -----------------------------------------------------
-- 🟪 SUBQUERIES
-- -----------------------------------------------------

-- Employees in same department as 'Alice'
SELECT * FROM employees
WHERE dept_id = (
    SELECT dept_id FROM employees WHERE name = 'Alice'
);

-- -----------------------------------------------------
-- ⬛ COMMON TABLE EXPRESSIONS (CTEs)
-- -----------------------------------------------------

-- Use CTE to find high earners
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 7000
)
SELECT name FROM high_earners;

-- -----------------------------------------------------
-- 🟨 SET OPERATIONS (LIMITED SUPPORT IN MYSQL)
-- -----------------------------------------------------

-- Combine employees and managers by name
SELECT name FROM employees
UNION
SELECT name FROM employees WHERE id IN (
    SELECT manager_id FROM employees
);

-- Simulating EXCEPT using LEFT JOIN and IS NULL
SELECT e1.name
FROM employees e1
LEFT JOIN employees e2 ON e1.name = e2.name AND e1.dept_id IS NULL
WHERE e2.name IS NULL;

-- -----------------------------------------------------
-- 🧠 WINDOW FUNCTIONS (MySQL 8+)
-- -----------------------------------------------------

-- Rank employees by salary within departments
SELECT name, dept_id, salary,
       RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- -----------------------------------------------------
-- ⚙️ TRANSACTIONS
-- -----------------------------------------------------

-- Safe transfer of salary using transactions
START TRANSACTION;
UPDATE employees SET salary = salary - 500 WHERE id = 1;
UPDATE employees SET salary = salary + 500 WHERE id = 2;
COMMIT;

-- -----------------------------------------------------
-- 🔐 USER PERMISSIONS (MySQL Syntax)
-- -----------------------------------------------------

-- Grant read-only access to a QA user
GRANT SELECT ON sql_practice.* TO 'qa_user'@'localhost';

-- Revoke write access from the QA user
REVOKE UPDATE ON employees FROM 'qa_user'@'localhost';

-- -----------------------------------------------------
-- 🧱 DDL: ALTERING TABLES
-- -----------------------------------------------------

-- Add a hire date column
ALTER TABLE employees ADD COLUMN hire_date DATE;

-- Remove the hire date column
ALTER TABLE employees DROP COLUMN hire_date;

-- -----------------------------------------------------
-- 🧩 STORED FUNCTIONS (MySQL)
-- -----------------------------------------------------

-- Function to return number of employees in a department
DELIMITER //
CREATE FUNCTION get_employee_count(dept INT)
RETURNS INT
READS SQL DATA
BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM employees WHERE dept_id = dept;
  RETURN total;
END //
DELIMITER ;

-- -----------------------------------------------------
-- 🔥 BONUS: METADATA QUERIES
-- -----------------------------------------------------

-- Show all tables
SHOW TABLES;

-- Describe employees table structure
DESCRIBE employees;

-- Columns in employees table (info schema)
-- noinspection SqlResolve
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'sql_practice' AND TABLE_NAME = 'employees';