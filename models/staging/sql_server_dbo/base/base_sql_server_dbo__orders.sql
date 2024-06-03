with 

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        shipping_service,
        shipping_cost as shipping_cost_dollar,
        address_id,
        created_at as created_at_utc,
        promo_id,
        estimated_delivery_at as estimated_delivery_at_utc,
        order_cost as order_cost_dollar,
        user_id,
        order_total as order_total_dollar,
        delivered_at as delivered_at_utc,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced as date_load_utc

    from source
)

select * from renamed
