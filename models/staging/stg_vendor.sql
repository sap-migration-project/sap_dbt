{{ config(materialized='view') }}

select 
    mandt       as client,
    lifnr       as vendor_number,
    name1       as vendor_name,
    ort01       as city,
    land1       as country
from {{ source('raw_sap', 'LFA1') }}
qualify row_number() over(partition by mandt, lifnr order by name1) = 1