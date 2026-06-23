{{
    config(
        materialized='view'
    )
}}

SELECT
    mandt,
    kunnr as customer_number,
    name1 as customer_name,
    name2 as customer_name_2,
    ort01 as city,
    pstlz as postal_code,
    land1 as country_code,
    regio as region,
    brsch as industry_key,
    kdgrp as customer_group,
    loevm as deletion_flag

from {{ source('raw_sap','KNA1') }}