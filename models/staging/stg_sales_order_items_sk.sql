    -- models/staging/stg_sales_order_items.sql
select
    {{ dbt_utils.generate_surrogate_key(['vbeln', 'posnr']) }} as sales_order_item_sk,
    vbeln as sales_order_number,
    posnr as item_number,
    matnr as material_number,
    kwmeng as order_quantity
from {{ source('raw_sap', 'VBAP') }}
