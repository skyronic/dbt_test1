{{
    config(
        materialized='view'
    )
}}

select 
    first_name,
    last_name,
    concat(first_name, ' ', last_name) as full_name
from {{ source('raw', 'raw_customers') }}
