{% macro copy_to_landing_table() %}
  COPY INTO landing_table
  FROM @dbt_assignement.public.RAW
  FILE_FORMAT = (TYPE = 'JSON');
  {% endmacro %}
