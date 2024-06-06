with

source_users as(
    select * from {{ ref('dim_users') }}
),

source_events as(
    select * from {{ ref('fct_events') }}
),

source_type_events as(
    select * from {{ ref('int_shipping_service_user') }}
),

mart_product as(
    select
        se.session_id,
        se.user_id,
        su.first_name,
        su.email,
        min(se.created_at_utc) as first_event_time_utc,
        max(se.created_at_utc) as last_event_time_utc,
        datediff(minute, first_event_time_utc, last_event_time_utc) as session_length_minutes,
        ste.page_view_amount as page_view,
        ste.add_to_cart_amount as add_to_cart,
        ste.checkout_amount as checkout,
        ste.package_shipped_amount as package_shipped
    from source_events se 
    join source_users su
    on se.user_id=su.user_id
    join source_type_events ste
    on se.session_id = ste.session_id
    group by 1, 2, 3, 4, 8, 9, 10, 11
)

select * from mart_product