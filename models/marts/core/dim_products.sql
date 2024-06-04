with 

source as (

    select * from {{ ref('stg_sql_server_dbo__products') }}

),

renamed as (

    select
        product_id,
        price_dollar,
        name,
        inventory,
        _fivetran_deleted,
        date_load_utc

    from source
)

select * from renamed
