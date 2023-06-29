{% macro copy_to_landing(table) %}

  COPY INTO dbt_assignement.public.{{table}} from
  (select 
       $1 as RAW
       from @utility_db.public.json_format
       ) 
  FILE_FORMAT = (TYPE = 'JSON');

{% endmacro %}