{{
    config(
        materialized='incremental',
        unique_key='EMPLOYEEID'
        ) }}
with scd1rawhist as(
    select 
    EMPLOYEEID,
    FIRSTNAME,
    LASTNAME,
    EMAIL,
    HIREDATE,
    UPDATEDATE
    FROM(
        select 
    EMPLOYEEID,
    FIRSTNAME,
    LASTNAME,
    EMAIL,
    HIREDATE,
    UPDATEDATE,
    ROW_NUMBER() OVER (PARTITION BY EMPLOYEEID ORDER BY UPDATEDATE DESC) as row_num
    FROM {{ ref('falttened') }}
  )
  WHERE row_num = 1
    )
select * from scd1rawhist

