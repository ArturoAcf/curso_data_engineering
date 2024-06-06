with

source_user as(
    select * from {{ ref('dim_users') }}
),

source_address as(
     select * from {{ ref('dim_addresses') }}
),

source_orders as(
    select * from {{ ref('int_fct_orders') }}
),

-- source_product as(
--     select * from {{ ref('fct_product_grain') }}
-- ),

mart_marketing as(
    select
        su.user_id,
        su.first_name,
        su.last_name,
        su.phone_number,
        su.email,
        su.created_at_utc,
        su.updated_at_utc,
        sa.address,
        sa.zipcode,
        sa.state,
        sa.country,
        count(distinct so.order_id) as total_number_orders,
        sum(so.order_total_dollar) as total_order_cost,
        sum(so.shipping_cost_dollar) as total_shipping_cost,
        sum(so.discount_dollar) as total_discount,
        sum(so.product_quantity) as total_quantity_product,
        count(so.order_id) as total_different_products
    from source_user su
    left join source_address sa
    on su.address_id = sa.address_id
    join source_orders so
    on su.user_id = so.user_id
    -- join source_product sp
    -- on so.order_id = sp.order_id
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
    order by 2
)

select * from mart_marketing