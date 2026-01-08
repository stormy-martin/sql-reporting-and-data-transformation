-- reporting_queries.sql
-- Extracts raw data and generates detailed and summary rental reports

-- Populate detailed rental report
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

-- View detailed rental report
SELECT *
FROM detailed_rental_report
ORDER BY store_id, payment_date ASC;

-- View summary rental report
SELECT *
FROM summary_rental_report
ORDER BY store_id, payment_month_year ASC;
