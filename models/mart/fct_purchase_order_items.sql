{{
    config(
        materialized='incremental',
        unique_key=['mandt','purchase_order_number','item_number'],
        incremental_strategy= 'merge',
        on_schema_change='append_new_columns'
    )
}}

select
    spoi.mandt,
    spoi.purchase_order_number,
    spoi.item_number,
    spoi.material_number,
    spoi.material_discription as material_description,
    spoi.plant,
    spoi.quantity,
    spoi.unit_of_measure,
    spoi.net_price,
    spoi.currency,
    spoi.delivery_date,
    spoi.gross_order_value,
    spoi.vendor_number,
    spoi.vendor_name,
    spoi.company_code,
    current_timestamp() as dbt_loaded_at
from {{ ref('stg_purchase_order_items') }} spoi

{% if is_incremental() %}
    where spoi.delivery_date >= (select coalesce(dateadd(day, -7, max(delivery_date)), '1990-1-1') from {{ this }})
{% endif %}
