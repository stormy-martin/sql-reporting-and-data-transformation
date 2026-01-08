-- joins_and_reports.sql
-- Demonstrates multi-table joins for reporting purposes

SELECT
  coffee.coffee_id,
  coffee.coffee_name,
  coffee.price_per_pound,
  coffee_shop.shop_name,
  coffee_shop.city AS shop_city,
  supplier.company_name AS supplier_name,
  supplier.country AS supplier_country
FROM COFFEE
JOIN COFFEE_SHOP
  ON coffee.shop_id = coffee_shop.shop_id
JOIN SUPPLIER
  ON coffee.supplier_id = supplier.supplier_id;
