
{{ config(materialized='table') }}

WITH sales_data AS (
  SELECT
    customers.C_CUSTOMER_SK,
    SUM(orders.SS_SALES_PRICE * orders.SS_QUANTITY) AS revenue
  FROM
    {{ ref('Customers') }} AS customers
  JOIN
    {{ ref('Orders') }} AS orders ON customers.C_CUSTOMER_SK = orders.SS_CUSTOMER_SK
  GROUP BY
    customers.C_CUSTOMER_SK
)

SELECT *
FROM sales_data;
