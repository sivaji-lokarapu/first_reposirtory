{{config(materialized='table') }}

with scd1 as(
    select 
  RAW:employeeId::int AS employeeid,
  RAW:email::string AS email,
  RAW:firstName::string AS firstName,
  RAW:hireDate::date AS hireDate,
  RAW:lastName::string AS lastName,
  RAW:updateDate::date AS updateDate
  from dbt_assignement.public.rawdata)

  select * from scd1
