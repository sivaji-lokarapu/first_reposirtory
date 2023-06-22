
{{ config(materialized='table',schema='schema1',alias='sales_data') }}

WITH sales_data AS (
  SELECT
    customers.C_CUSTOMER_SK,
    SUM(orders.SS_SALES_PRICE * orders.SS_QUANTITY) AS revenue
  FROM
    {{ ref('customers') }} AS customers
  JOIN
    {{ ref('orders') }} AS orders ON customers.C_CUSTOMER_SK = orders.SS_CUSTOMER_SK
  GROUP BY
    customers.C_CUSTOMER_SK
)

SELECT *
FROM sales_data