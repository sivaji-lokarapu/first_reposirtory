
{{ config(materialized='table', schema='schema1',alias='orders') }}

WITH store_sales AS (
  SELECT
    SS_CUSTOMER_SK,
    SS_SOLD_DATE_SK,
    SS_ITEM_SK,
    SS_SALES_PRICE,
    SS_QUANTITY,
    SS_STORE_SK
  FROM
    raw.schema1.orders
  LIMIT 10000 
)

SELECT *
FROM store_sales

