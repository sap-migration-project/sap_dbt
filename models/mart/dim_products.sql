{{
    config(
        materialized='table'
    )
}}

select distinct
    material_number,
    material_description

from {{ ref('stg_sales_order_items')}}
where material_number is not null