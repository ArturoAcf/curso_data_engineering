with 

source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        page_url,
        md5(event_type) as event_type_id,
        user_id,
        case
            when product_id = '' then md5('producto_vacio')
            else product_id
        end as product_id,
        session_id,
        created_at as created_at_utc,
        case
            when order_id = '' then md5('void_order')
            else order_id
        end as order_id,
        _fivetran_deleted,
        _fivetran_synced AS date_load_UTC

    from source

)

select * from renamed
