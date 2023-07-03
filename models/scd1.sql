{{ config(materialized='incremental', unique_key='EMPLOYEEID') }}

WITH scd1 AS (
  SELECT 
    EMPLOYEEID,
    FIRSTNAME,
    LASTNAME,
    EMAIL,
    HIREDATE,
    UPDATEDATE,
    startdate,
    enddate
  FROM (
    SELECT 
      EMPLOYEEID,
      FIRSTNAME,
      LASTNAME,
      EMAIL,
      HIREDATE,
      startdate,
      enddate,
      UPDATEDATE,
      ROW_NUMBER() OVER (PARTITION BY EMPLOYEEID ORDER BY UPDATEDATE DESC) AS row_num
    FROM {{ ref('flattened') }}
  )
  WHERE row_num = 1
)

SELECT * FROM scd1