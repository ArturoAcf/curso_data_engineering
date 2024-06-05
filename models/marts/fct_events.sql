with 

source as (

    select * from {{ ref('stg_sql_server_dbo__events') }}

),

renamed as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        created_at_utc,
        order_id,
        _fivetran_deleted,
        date_load_utc
    from source

)

select * from renamed
