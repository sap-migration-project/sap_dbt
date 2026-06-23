{{
    config(
        materialized='table'
    )
}}

select
    customer_number,
    customer_name,
    city,
    country_code,
    customer_group,

from {{ ref('stg_customers') }}

where deletion_flag is null