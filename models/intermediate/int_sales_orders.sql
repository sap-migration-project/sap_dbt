{{ config(materialized='view') }}

--stg_sales_orders
select 
    so.sales_order_number,
    so.order_created_date,
    so.order_type,
    so.customer_number,
    so.customer_name,
    so.city,
    so.country_code,

--stg_sales_order_items
    soi.item_number,
    soi.material_number,
    soi.material_description,
    soi.order_quantity,
    soi.item_price,

    soi.order_quantity * soi.item_price as line_amount,

    so.currency

from {{ ref('stg_sales_orders') }} so

inner join {{ ref('stg_sales_order_items') }} soi
    on so.sales_order_number    =   soi.sales_order_number

