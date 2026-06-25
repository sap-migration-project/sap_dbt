{% snapshot snap_vendors %}

{{
    config(
        target_schema='DBT_SC',
        target_database='DBT_DB',
        unique_key='vendor_number',
        strategy='check',
        check_cols=[
            'vendor_name',
            'vendor_city',
            'vendor_country'
        ]
    )
}}

select distinct
    vendor_number,
    vendor_name,
    vendor_city,
    vendor_country
from {{ ref('stg_purchase_order_items') }}
where vendor_number is not null

{% endsnapshot %}