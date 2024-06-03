with 

source as (

    select * from {{ ref('base_sql_server_dbo__promos') }}

),

renamed as (

    select
        md5(promo_id) as promo_id,
        promo_id as nombre_promo,
        discount_dollar,
        md5(status) as promo_status_id,
        _fivetran_deleted,
        date_load_utc

    from source
    union all
    select 
        md5('sin_promo'),
        'sin_promo',
        0,
        md5('inactive'),
        null,
        null
)

select * from renamed
