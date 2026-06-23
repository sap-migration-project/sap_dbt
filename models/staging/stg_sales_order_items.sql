{{ config(materialized='view') }}

select
    VBAP.vbeln          as sales_order_number,
    VBAP.posnr          as item_number,
    VBAP.matnr          as material_number,
    VBAP.arktx          as material_description,
    VBAP.kwmeng         as order_quantity,
    VBAP.netpr          as item_price,
    VBAK.erdat          as order_date,
    VBAK.auart          as order_type,
    VBAK.kunnr          as customer_number,
    KNA1.name1          as customer_name,
    VBAK.waerk          as currency

from {{ source('raw_sap' , 'VBAK') }} VBAK

inner join {{ source('raw_sap','VBAP') }} VBAP
    on VBAK.mandt = VBAP.mandt
    and VBAK.vbeln = VBAP.vbeln

left join {{ source('raw_sap','KNA1') }} KNA1
    on VBAK.mandt  =  KNA1.mandt
    and VBAK.kunnr = KNA1.kunnr