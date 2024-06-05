with 

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed as (

    select
        product_id,
        price as price_dollar,
        name,
        inventory,
        _fivetran_deleted,
        {{set_to_utc('_fivetran_synced')}} as date_load_utc

    from source
    union all
    select 
        md5('producto_vacio'),
        0,
        'producto_vacio',
        0,
        null,
        null
)

select * from renamed
