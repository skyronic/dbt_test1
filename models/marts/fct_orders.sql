{{
    config(
        materialized='table'
    )
}}

with orders as (
    select *
    from {{ ref('stg_orders') }}
),

payments as (
    select 
        order_id,
        sum(amount) as total_amount,
        array_agg(distinct payment_method) as payment_methods
    from {{ source('raw', 'raw_payments') }}
    group by 1
)

select 
    o.user_id,
    o.order_date,
    o.status,
    o.is_completed,
    coalesce(p.total_amount, 0) as total_amount,
    p.payment_methods
from orders o
left join payments p
    on p.order_id = o.user_id
