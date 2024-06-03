with 

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed as (

    select
        order_id,
        product_id,
        quantity as product_quantity,
        _fivetran_deleted,
        _fivetran_synced as date_load_utc
        
    from source

)

select * from renamed
