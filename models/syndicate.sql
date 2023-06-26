{{ config(materialized='table') }}


WITH deduplicated_data AS (
  SELECT DISTINCT *
  FROM {{ref('rawhist') }}
)

SELECT *
FROM deduplicated_data;


