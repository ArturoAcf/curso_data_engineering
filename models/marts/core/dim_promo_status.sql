with 

source as (

    select * from {{ ref('stg_sql_server_dbo__promo_status') }} 

),

renamed as (

    select
        promo_status_id,
        promo_status
    from source
)

select * from renamed
