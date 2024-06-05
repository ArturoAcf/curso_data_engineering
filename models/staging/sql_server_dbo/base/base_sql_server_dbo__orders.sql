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
        {{set_to_utc('created_at')}} as created_at_utc,
        promo_id,
        {{set_to_utc('estimated_delivery_at')}} as estimated_delivery_at_utc,
        order_cost as order_cost_dollar,
        user_id,
        order_total as order_total_dollar,
        {{set_to_utc('delivered_at')}} as delivered_at_utc,
        tracking_id,
        status,
        _fivetran_deleted,
        {{set_to_utc('_fivetran_synced')}} as date_load_utc

    from source
)

select * from renamed
