with 

source as (

    select * from {{ ref('stg_sql_server_dbo__promos') }}

),

renamed as (

    select
        promo_id,
        nombre_promo,
        discount_dollar,
        promo_status_id,
        _fivetran_deleted,
        date_load_utc

    from source
)

select * from renamed
