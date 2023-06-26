{{ config(materialized='table', schema='schema1', alias='rawhist_data') }}

{% copy_to_landing_table('landing_table') %}

WITH RAWHIST_DATA AS (
  SELECT
    *
  FROM
   {{ ref('landing_table') }}
)
SELECT
  RAW:As_of_date::timestamp as As_of_date,
  RAW:Calendar_Period::varchar(50) as Calendar_Period,
  RAW:account_type::varchar(50) as account_type,
  RAW:account_type_desc::varchar(50) as account_type_desc,
  RAW:author::varchar(50) as author,
  RAW:canada_price::varchar(50) as canada_price,
  RAW:first_bill_date::varchar(50) as first_bill_date,
  RAW:foo::varchar(50) as foo,
  RAW:isbn::varchar(50) as isbn,
  RAW:isbn13::varchar(50) as isbn_13,
  RAW:order_type::varchar(50) as order_type,
  RAW:order_type_desc::varchar(50) as order_type_desc,
  RAW:sales_dollars::varchar(50) as sales_dollars,
  RAW:sales_type::varchar(50) as sales_type,
  RAW:sales_type_desc::varchar(50) as sales_type_desc,
  RAW:sales_units::varchar(50) as sales_units,
  RAW:title::varchar(50) as title,
  RAW:usa_price::varchar(50) as usa_price
FROM
  RAWHIST_DATA
LIMIT 500;
