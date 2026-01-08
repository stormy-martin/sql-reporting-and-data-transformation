-- schema.sql
-- Defines tables used for detailed and summary rental revenue reporting

CREATE TABLE detailed_rental_report (
  rental_id INT,
  store_id INT,
  payment_date VARCHAR(25),
  payment_amount NUMERIC(7,2)
);

CREATE TABLE summary_rental_report (
  store_id INT,
  payment_month_year VARCHAR(25),
  total_revenue NUMERIC(10,2)
);
