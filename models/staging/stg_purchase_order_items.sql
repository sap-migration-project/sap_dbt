{{ config(materialized='view') }}

SELECT
--Purchase Order Head EKKO PO ITEMS
    EKKO.mandt          as mandt,
    EKKO.ebeln          as purchase_order_number,
    EKKO.bukrs          as company_code,
    EKKO.bsart          as po_type,
    EKKO.bedat          as po_date,
    EKKO.ekorg          as purchasing_org,
    EKKO.ekgrp          as purchasing_group,
-- Vendor --LFA1  VENDOR MASTER
    LFA1.lifnr          as vendor_number,
    LFA1.name1          as vendor_name,
    LFA1.ort01          as vendor_city,
    LFA1.land1          as vendor_country,
--purchase order items
    EKPO.ebeln          as item_number,
    EKPO.matnr          as material_number,
    EKPO.txz01          as material_discription,
    EKPO.werks          as plant,
    EKPO.menge          as quantity,
    EKPO.meins          as unit_of_measure,
    EKPO.netpr          as net_price,
    EKPO.waers          as currency,
    EKPO.eindt          as delivery_date,
    EKPO.brtwr          as gross_order_value

from {{ source('raw_sap', 'EKPO') }} EKPO

left join {{ source('raw_sap' , 'EKKO') }} EKKO
    on  EKPO.mandt   =   EKKO.mandt
    and EKPO.ebeln   =   EKKO.ebeln

left join {{ source('raw_sap','LFA1')}} LFA1
    on  EKKO.mandt   =   LFA1.mandt
    and EKKO.lifnr   =   LFA1.lifnr
    

