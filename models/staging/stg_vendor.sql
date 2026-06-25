select * 
from(
    select *,
        row_number() over(partition by mandt, lifnr order by name1) as rn
        from {{ source('raw_sap', 'LFA1') }}
)
where rn =1