
{{ config(materialized='table',schema='schema1',alias='customers') }}

with customers as (SELECT
  C_CUSTOMER_SK,
  C_FIRST_NAME,
  C_BIRTH_COUNTRY
FROM
  raw.schema1.customers)

  select * from customers
