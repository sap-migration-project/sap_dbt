{{ config(materialized='view') }}

select
    VBAK.vbeln          as sales_order_number,
    VBAK.erdat          as order_created_date,
    VBAK.erzet          as order_created_time,
    VBAK.ernam          as created_by_user,
    VBAK.auart          as order_type,
    VBAK.kunnr          as customer_number,

    KNA1.name1          as customer_name,
    KNA1.ort01          as city,
    KNA1.land1          as country_code,
    KNA1.regio          as region,
    KNA1.kdgrp          as customer_group,

    VBAK.netwr          as net_order_value,
    VBAK.waerk          as currency

from {{ source('raw_sap', 'VBAK') }} VBAK

left join {{ source('raw_sap','KNA1') }} KNA1
    on VBAK.mandt = KNA1.mandt
    and VBAK.kunnr = KNA1.kunnr