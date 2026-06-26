{{
    config(
        materialized='incremental',
        unique_key='vendor_number',
        incremental_strategy='merge'
    )
}}

with source as(
select
    lifnr                as vendor_number,
    name1                as Vendor_name,
    ort01                as city,
    land1                as country,
    current_timestamp()  as updated_at
    from {{ source('raw_sap', 'LFA1') }}
    qualify row_number() over (partition by lifnr order by name1) =1
    )

select
    vendor_number,
    vendor_name,
    city,
    country,
    updated_at,
    true                as is_current,
    updated_at          as valid_from,
    null::timestamp     as valid_to
from source