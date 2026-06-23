{{
    config(
        materialized='table'
    )
}}

select
    sales_order_number,
    item_number,

    customer_number,
    material_number,

    order_created_date,
    
    order_quantity,
    item_price,

    line_amount as sales_amount,

    currency
from {{ ref('int_sales_orders') }}
