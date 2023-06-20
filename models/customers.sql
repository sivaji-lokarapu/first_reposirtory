
{{ config(materialized='table',schema='schema1') }}

with customer as (SELECT
  C_CUSTOMER_SK,
  C_FIRST_NAME,
  C_BIRTH_COUNTRY
FROM
  SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER)

  select * from customer
