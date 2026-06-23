{{ config(materialized='view') }}

select
    EKKO.ebeln              as purchase_order_number,
    EKKO.bukrs              as company_code,
    EKKO.bsart              as po_type,
    EKKO.bedat              as po_date,
    EKKO.ekorg              as purchasing_org,
    EKKO.ekgrp              as purchasing_group,
    EKKO.waers              as currency,


    LFA1.lifnr              as vendor_number,
    LFA1.name1              as vendor_name,
    LFA1.ort01              as city,
    LFA1.land1              as country

from {{ source('raw_sap' , 'EKKO') }} EKKO
left join {{ source('raw_sap', 'LFA1') }} LFA1
    on EKKO.mandt   =   LFA1.mandt
    and EKKO.lifnr  = LFA1.lifnr
