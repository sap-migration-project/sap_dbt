SELECT 
*,
{{ dbt_utils.generate_surrogate_key([
        'sales_order_number',
        'item_number'
]) }} as sales_order_item_key
from {{ ref('int_sales_orders') }}