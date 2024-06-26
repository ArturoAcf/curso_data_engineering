with 

source as (

    select * from {{ ref('base_sql_server_dbo__orders') }}

),

renamed as (

    select
        order_id,
        case
            when shipping_service != '' then md5(shipping_service)
            else md5('no_shipping_service')
        end as shipping_service_id,
        shipping_cost_dollar,
        address_id,
        created_at_utc,
        IFF(promo_id = '', md5('sin_promo'), md5(promo_id)) as promo_id,
        estimated_delivery_at_utc,
        order_cost_dollar,
        user_id,
        order_total_dollar,
        delivered_at_utc,
        -- IFF(tracking_id = '', null, tracking_id) as tracking_id,
        {{ nothing_to_null('tracking_id') }} as tracking_id,
        md5(status) as order_status_id,
        _fivetran_deleted,
        date_load_UTC

    from source
    union all
    select 
        md5('void_order'),
        md5('no_shipping_service'),
        0,
        null,
        null,
        md5('sin_promo'),
        null,
        0,
        null,
        null,
        null,
        null,
        md5('preparing'),
        null,
        null
)

select * from renamed
