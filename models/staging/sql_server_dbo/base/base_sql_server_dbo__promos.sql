with 

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        promo_id,
        discount as discount_dollar,
        status,
        _fivetran_deleted,
        {{set_to_utc('_fivetran_synced')}} as date_load_utc

    from source
)

select * from renamed
