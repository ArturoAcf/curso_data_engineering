with 

source_orders as (
    select * from {{ ref('stg_sql_server_dbo__orders') }}
),

source_order_items as (
    select * from {{ ref('stg_sql_server_dbo__order_items') }}
),

source_products as (
    select * from {{ ref('stg_sql_server_dbo__products') }}
),

source_promos as (
    select * from {{ ref('stg_sql_server_dbo__promos') }}
),

fct_orders as (
    select
        -- rank() over(partition by so.order_id order by so_i.product_id) as _row,
        so.order_id,
        so_i.product_id,
        so_i.product_quantity,
        (sp.price_dollar*so_i.product_quantity) as price_per_quantity_of_products,
        so.shipping_service_id,
        so.shipping_cost_dollar,
        so.promo_id,
        spr.discount_dollar,
        so.order_cost_dollar,
        so.order_total_dollar, -- -> El problema es como con el resto. Todo lo asociado a orders se repite.
        so.user_id,
        so.address_id,
        so.created_at_utc,
        so.estimated_delivery_at_utc,
        so.delivered_at_utc,
        so.tracking_id,
        so.order_status_id
    from source_orders so
    join source_order_items so_i
    on so.order_id = so_i.order_id
    join source_products sp
    on so_i.product_id = sp.product_id
    join source_promos spr
    on so.promo_id = spr.promo_id
    order by order_id -- , _row
)

select * from fct_orders
