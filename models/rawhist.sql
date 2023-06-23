
{% macro rawhist_model() %}
  {{ copy_to_landing_table() }}
  
  WITH flattened_data AS (
    SELECT
      AS_of_date,
      Calendar_Period,
      account_type,
      account_type_desc,
      author,
      canada_price,
      first_bill_date,
      foo,
      isbn,
      isbn13,
      order_type,
      order_type_desc,
      sales_dollars,
      sales_type,
      sales_type_desc,
      sales_units,
      title,
      usa_price
    FROM landing_table
  )
  
  CREATE OR REPLACE TABLE rawhist_table AS (
    SELECT
      *,
      CURRENT_TIMESTAMP() AS load_date
    FROM flattened_data
  );
{% endmacro %}
