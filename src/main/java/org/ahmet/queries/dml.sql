INSERT INTO departments (name) VALUES
('HR'), ('IT'), ('Finance');

INSERT INTO employees (name, dept_id, manager_id, salary) VALUES
('Alice', 1, NULL, 5000),
('Bob', 2, 1, 6000),
('Charlie', 2, 1, 5500),
('Diana', 3, NULL, 7000),
('Eve', 1, 1, 4800);

INSERT INTO projects (name, dept_id) VALUES
('Recruitment', 1),
('System Upgrade', 2),
('Budget Planning', 3);

INSERT INTO employee_projects (employee_id, project_id) VALUES
(1, 1), (2, 2), (3, 2), (4, 3), (5, 1);

select * from employees;
select * from departments;
select * from projects;
select * from employee_projects;
