-- transformations.sql
-- Defines custom SQL functions, triggers, and stored procedures
-- used to transform and summarize rental revenue data

-- Function to format payment dates as Month YYYY
CREATE OR REPLACE FUNCTION rental_by_date(rental_date TIMESTAMP)
RETURNS TEXT
AS $$
BEGIN
  RETURN TO_CHAR(rental_date, 'Month YYYY');
END;
$$ LANGUAGE plpgsql;

-- Trigger function to refresh the summary table
CREATE OR REPLACE FUNCTION refresh_function()
RETURNS TRIGGER
AS $$
BEGIN
  DELETE FROM summary_rental_report;

  INSERT INTO summary_rental_report
  SELECT
    store_id,
    payment_date,
    SUM(payment_amount)
  FROM detailed_rental_report
  GROUP BY store_id, payment_date
  ORDER BY store_id, payment_date;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update summary report after inserts
CREATE TRIGGER updated_summary_report
AFTER INSERT ON detailed_rental_report
FOR EACH STATEMENT
EXECUTE PROCEDURE refresh_function();

-- Stored procedure to refresh both detailed and summary tables
CREATE OR REPLACE PROCEDURE refresh_tables()
AS $$
BEGIN
  DELETE FROM detailed_rental_report;
  DELETE FROM summary_rental_report;

  INSERT INTO detailed_rental_report
  SELECT
    p.rental_id,
    s.store_id,
    rental_by_date(p.payment_date),
    p.amount
  FROM payment p
  JOIN rental r ON p.rental_id = r.rental_id
  JOIN staff s ON r.staff_id = s.staff_id
  ORDER BY store_id, payment_date, p.amount;

  RETURN;
END;
$$ LANGUAGE plpgsql;
