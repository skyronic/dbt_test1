{{
    config(
        materialized='view'
    )
}}

select 
    user_id,
    order_date::date as order_date,
    status,
    case 
        when status = 'completed' then 1
        else 0
    end as is_completed
from {{ source('raw', 'raw_orders') }}
