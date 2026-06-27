{% snapshot dim_vendor_scd2 %}

{{
    config(
      target_schema='dbt_sc',
      unique_key='vendor_number',
      strategy='check',
      check_cols=['vendor_name', 'city', 'country'],
    )
}}

select
    lifnr   as vendor_number,
    name1   as vendor_name,
    ort01   as city,
    land1   as country
from {{ source('raw_sap', 'LFA1') }}
qualify row_number() over (partition by lifnr order by name1) = 1

{% endsnapshot %}