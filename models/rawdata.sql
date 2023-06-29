{{ config(materialized='table') }}

{{ copy_to_landing('rawdata') }}


select * 
from  dbt_assignement.public.rawdata
limit 500

