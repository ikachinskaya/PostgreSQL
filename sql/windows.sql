CREATE SCHEMA wf;
-------------------------------
CREATE TABLE wf.departments(
  id serial PRIMARY KEY,
  "name" varchar(64) NOT NULL
);
-------------------------------
CREATE TABLE wf.employees (
  id serial PRIMARY KEY,
  department_id integer REFERENCES wf.departments,
  salary numeric(10, 2) NOT NULL CHECK (salary > 0),
  "name" text NOT NULL,
  hire_date date NOT NULL CHECK(hire_date <= current_date)
);
------------------------------
INSERT INTO wf.departments("name")
VALUES ('SALES'),
  ('HR'),
  ('DEVELOPMENT'),
  ('QA'),
  ('TOP MANAGEMENT');
------------------------------
INSERT INTO wf.employees ("name", salary, hire_date, department_id)
VALUES ('Test Developer', 10000, '1990-1-1', 3),
  ('John Doe', 6000, '2010-1-1', 2),
  ('Matew Doe', 3456, '2020-1-1', 2),
  ('Matew Doe1', 53462, '2020-1-1', 3),
  ('Matew Doe2', 124543, '2012-1-1', 4),
  ('Matew Doe3', 12365, '2004-1-1', 5),
  ('Matew Doe4', 1200, '2000-8-1', 5),
  ('Matew Doe5', 2535, '2010-1-1', 2),
  ('Matew Doe6', 1000, '2014-1-1', 3),
  ('Matew Doe6', 63456, '2017-6-1', 1),
  ('Matew Doe7', 1000, '2020-1-1', 3),
  ('Matew Doe8', 346434, '2015-4-1', 2),
  ('Matew Doe9', 3421, '2018-1-1', 3),
  ('Matew Doe0', 34563, '2013-2-1', 5),
  ('Matew Doe10', 2466, '2011-1-1', 1),
  ('Matew Doe11', 9999, '1999-1-1', 5),
  ('TESTing 1', 1000, '2019-1-1', 2),
  ('New Tester', 1200, '2015-4-1', 4);
------------------------------
-- количество сотрудников в отделе
SELECT departments."name",
  count(departments.id) AS employees_in_department
FROM wf.departments
  JOIN wf.employees ON employees.department_id = departments.id
GROUP BY departments.id;
------------------------------
-- сотрудник и его отдел
SELECT employees."name",
  departments."name"
FROM wf.employees
  JOIN wf.departments ON departments.id = employees.department_id;
------------------------------
-- средняя ЗП по отделам
SELECT departments."name",
  avg(employees.salary)
FROM wf.employees
  JOIN wf.departments ON departments.id = employees.department_id
GROUP BY departments.id;
------------------------------
-- инфо про юзера, название его отдела, средння ЗП отдела
SELECT employees.*,
  departments."name",
  avg_salary_table.avg_salary
FROM wf.departments
  JOIN wf.employees ON employees.department_id = departments.id
  JOIN (
    SELECT departments.id,
      departments."name",
      avg(employees.salary) AS avg_salary
    FROM wf.departments
      JOIN wf.employees ON employees.department_id = departments.id
    GROUP BY departments.id
  ) AS avg_salary_table ON departments.id = avg_salary_table.id;
------------------------------
-- Window Functions
SELECT employees.*,
  departments.name,
  avg(employees.salary) OVER (PARTITION BY departments.id) as avg_salary,
  avg(employees.salary) OVER () as avg_salary_for_company
FROM wf.employees
  JOIN wf.departments ON departments.id = department_id;
------------------------------
--Сортировка в Window Functions
SELECT employees.*,
  departments.name,
  avg(employees.salary) OVER (
    PARTITION BY departments.id
    ORDER BY employees.salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) as avg_salary_for_department,
  avg(employees.salary) OVER () as avg_salary_for_company
FROM wf.employees
  JOIN wf.departments ON departments.id = employees.department_id;