

{% macro syndicated_model() %}
  {{ rawhist_model() }}
  
  CREATE OR REPLACE TABLE syndicated_table AS (
    SELECT DISTINCT *
    FROM rawhist_table
  );
{% endmacro %}
