{% snapshot scd2rawhist_model %}

{{
   config(
       target_database='dbt_assignement',
       target_schema='public',
       unique_key='EMPLOYEEID',
       strategy='check',
       check_cols=['FIRSTNAME', 'LASTNAME', 'EMAIL']
   )
}}

SELECT
  EMPLOYEEID,
  FIRSTNAME,
  LASTNAME,
  EMAIL,
  HIREDATE,
  UPDATEDATE
FROM {{ ref('flattened') }}

{% endsnapshot %}
