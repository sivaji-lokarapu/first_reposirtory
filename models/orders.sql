
{{ config(materialized='table') }}

WITH store_sales AS (
  SELECT
    SS_CUSTOMER_SK,
    SS_SOLD_DATE_SK,
    SS_ITEM_SK,
    SS_SALES_PRICE,
    SS_QUANTITY,
    SS_STORE_SK
  FROM
    SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.STORE_SALES
  LIMIT 10000 -- Limiting to 10,000 rows
)

SELECT *
FROM store_sales;

