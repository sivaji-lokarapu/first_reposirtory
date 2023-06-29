{{
  config(
    materialized='incremental',
    unique_key='EMPLOYEEID'
  )
}}

-- Insert new records
WITH new_records AS (
  SELECT
    EMPLOYEEID,
    FIRSTNAME,
    LASTNAME,
    EMAIL,
    HIREDATE,
    UPDATEDATE,
    ROW_NUMBER() OVER (PARTITION BY EMPLOYEEID ORDER BY UPDATEDATE DESC) AS row_num
  FROM {{ ref('flattened') }}
)

INSERT INTO scd2rawhist (
  EMPLOYEEID,
  FIRSTNAME,
  LASTNAME,
  EMAIL,
  HIREDATE,
  UPDATEDATE,
  CURRENT_FLAG
)
SELECT
  EMPLOYEEID,
  FIRSTNAME,
  LASTNAME,
  EMAIL,
  HIREDATE,
  UPDATEDATE,
  CASE WHEN row_num = 1 THEN 1 ELSE 0 END AS CURRENT_FLAG
FROM new_records
WHERE row_num = 1;

-- Update existing records
WITH latest_records AS (
  SELECT
    EMPLOYEEID,
    FIRSTNAME,
    LASTNAME,
    EMAIL,
    HIREDATE,
    UPDATEDATE,
    ROW_NUMBER() OVER (PARTITION BY EMPLOYEEID ORDER BY UPDATEDATE DESC) AS row_num
  FROM scd2rawhist
)

UPDATE scd2rawhist
SET CURRENT_FLAG = 0
WHERE EMPLOYEEID IN (
  SELECT EMPLOYEEID
  FROM latest_records
  WHERE row_num > 1
);


