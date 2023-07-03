{{ config(materialized='table') }}

WITH scd1 AS (
  SELECT 
    RAW:employeeId::int AS employeeid,
    RAW:email::string AS email,
    RAW:firstName::string AS firstname,
    RAW:hireDate::date AS hiredate,
    RAW:lastName::string AS lastname,
    RAW:updateDate::date AS updatedate,
    RAW:startdate::date AS startdate,
    RAW:enddate::date AS enddate
  FROM dbt_assignement.public.rawdata
)

SELECT * FROM scd1
