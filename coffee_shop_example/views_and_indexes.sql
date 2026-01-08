-- views_and_indexes.sql
-- Defines views and indexes to support reporting and query performance

CREATE VIEW EmployeeFullName AS
SELECT
  employee_id,
  CONCAT(first_name, ' ', last_name) AS employee_full_name,
  hire_date,
  job_title,
  shop_id
FROM EMPLOYEE;

CREATE INDEX idx_coffee_name
ON COFFEE (coffee_name);
