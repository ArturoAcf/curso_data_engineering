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
        _fivetran_synced AS date_load_UTC

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
