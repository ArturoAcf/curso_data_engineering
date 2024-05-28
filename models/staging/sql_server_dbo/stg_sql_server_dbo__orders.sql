with 

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        case
            when shipping_service != '' then md5(shipping_service)
            else md5('no_shipping_service')
        end as shipping_service_id,
        shipping_cost as shipping_cost_euros,
        address_id,
        created_at,
        case
            when promo_id != '' then md5('sin_promo')
            else md5(promo_id)
        end as promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        IFF(tracking_id = '', null, tracking_id) as tracking_id,
        md5(status) as order_status_id,
        _fivetran_deleted,
        _fivetran_synced AS date_load_UTC

    from source

)

select * from renamed
