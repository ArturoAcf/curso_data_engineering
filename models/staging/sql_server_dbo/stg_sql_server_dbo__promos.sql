with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        md5(promo_id) as promo_id,
        promo_id as nombre_promo,
        discount as discount_euros,
        status,
        _fivetran_deleted,
        _fivetran_synced AS date_load_UTC

    from source
    union all
    select 
        md5('sin_promo'),
        'sin_promo',
        0,
        'inactive',
        null,
        null
)

select * from renamed
