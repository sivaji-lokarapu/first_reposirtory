
{{ config(
  materialized='table',
  target_database='dbt_assignment',
  target_schema='public',
  unique_key='employeeid',
  strategy='merge',
  merge_cols=['employeeid']
) }}


WITH historical_records AS (
  SELECT
    employeeid,
    firstname,
    lastname,
    email,
    hiredate,
    startdate,
    enddate,
    version
  FROM {{ ref('scd1') }}
),


latest_records AS (
  SELECT
    a.employeeid,
    a.firstname,
    a.lastname,
    a.email,
    a.hiredate,
    b.startdate,
    CURRENT_TIMESTAMP() AS enddate,
    b.version + 1 AS version
  FROM {{ ref('flattened') }} a
  LEFT JOIN (
    SELECT employeeid, MAX(startdate) AS startdate, MAX(version) AS version
    FROM {{ ref('scd2') }}
    GROUP BY employeeid
  ) b ON a.employeeid = b.employeeid
)


MERGE INTO {{ ref('scd1') }} AS target
USING latest_records AS source
ON target.employeeid = source.employeeid
WHEN MATCHED THEN
  UPDATE SET
    target.enddate = source.enddate,
    target.version = source.version
WHEN NOT MATCHED THEN
  INSERT (
    employeeid,
    firstname,
    lastname,
    email,
    hiredate,
    startdate,
    enddate,
    version
  )
  VALUES (
    source.employeeid,
    source.firstname,
    source.lastname,
    source.email,
    source.hiredate,
    source.startdate,
    source.enddate,
    source.version
  );


