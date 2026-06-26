{{ config(
    materialized='incremental',
    unique_key='purchase_order_number'
) }}

with vendors as (
    select
        vendor_number,
        country
    from {{ ref('stg_vendor') }}
)

select
    EKKO.ebeln          as purchase_order_number,
    EKKO.bedat          as po_date,
    EKKO.lifnr          as vendor_number,
    EKKO.ekorg          as purchasing_org,
    EKKO.ekgrp          as purchasing_group,
    CASE 
        WHEN EKKO.waers IS NOT NULL THEN EKKO.waers
        WHEN v.country = 'US' THEN 'USD'
        WHEN v.country = 'DE' THEN 'EUR'
        WHEN v.country = 'FR' THEN 'EUR'
        WHEN v.country = 'SG' THEN 'SGD'
        WHEN v.country = 'IN' THEN 'INR'
        WHEN v.country = 'GB' THEN 'GBP'
        WHEN v.country = 'JP' THEN 'JPY'
        WHEN v.country = 'CN' THEN 'CNY'
        WHEN v.country = 'BR' THEN 'BRL'
        WHEN v.country = 'CA' THEN 'CAD'
        ELSE 'USD'
    END                 as currency,
    current_timestamp() as loaded_at

from {{ source('raw_sap', 'EKKO') }} EKKO
left join vendors v
    on EKKO.lifnr = v.vendor_number

{%- if is_incremental() %}
    where EKKO.bedat > (
        select max(po_date) from {{ this }}
    )
{%- endif %}