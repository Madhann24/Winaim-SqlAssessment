-- employee_management.sql

-- Create tables
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    hire_date DATE
);


CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);


CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10, 2),
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (employee_id, from_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Insert sample data
INSERT INTO departments (department_id, department_name) VALUES 
(1, 'HR'), 
(2, 'Engineering'), 
(3, 'Marketing');


INSERT INTO employees (first_name, last_name, department_id, hire_date) VALUES
('John', 'Doe', 1, '2023-06-01'),
('Jane', 'Smith', 2, '2022-06-01'),
('Sam', 'Brown', 3, '2021-01-01');


INSERT INTO salaries (employee_id, salary, from_date, to_date) VALUES
(1, 60000, '2023-06-01', '2024-06-01'),
(2, 80000, '2022-06-01', '2023-06-01'),
(3, 70000, '2021-01-01', '2022-01-01');

-- Find All Employees Who Have Been Hired in the Last Year
SELECT * 
FROM employees 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

--  Calculate the Total Salary Expenditure for Each Department
SELECT d.department_name, SUM(s.salary) AS total_expenditure
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Find the Top 5 Highest-Paid Employees Along with Their Department Names
SELECT e.first_name, e.last_name, d.department_name, s.salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
ORDER BY s.salary DESC
LIMIT 5;


