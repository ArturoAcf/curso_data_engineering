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

-- source_promos as (
--     select * from {{ ref('stg_sql_server_dbo__promos') }}
-- ),

fct_orders as (
    select
        -- rank() over(partition by so.order_id order by so_i.product_id) as _row,
        so.order_id,
        so_i.product_id,
        so_i.product_quantity,
        (sp.price_dollar*so_i.product_quantity) as price_per_quantity_of_products,
        -- so.shipping_service_id,
        -- so.shipping_cost_dollar,
        -- so.promo_id,
        -- spr.discount_dollar,
        -- so.order_cost_dollar,
        -- so.order_total_dollar, -- -> El problema es como con el resto. Todo lo asociado a orders se repite.
        -- so.user_id,
        -- so.address_id,
        -- so.created_at_utc,
        -- so.estimated_delivery_at_utc,
        -- so.delivered_at_utc,
        -- so.tracking_id,
        -- so.order_status_id
    from source_orders so
    join source_order_items so_i
    on so.order_id = so_i.order_id
    join source_products sp
    on so_i.product_id = sp.product_id
    -- join source_promos spr
    -- on so.promo_id = spr.promo_id
    order by order_id -- , _row
)

select * from fct_orders

-- https://www.linkedin.com/advice/1/how-can-you-handle-fact-table-multiple-granularities-z9xrf#:~:text=Here%20are%20some%20strategies%20for,applying%20these%20strategies%2C%20you%20can
-- https://community.fabric.microsoft.com/t5/Desktop/Need-to-append-2-sets-of-data-with-different-granularity-not/td-p/2773808
-- https://community.fabric.microsoft.com/t5/Desktop/How-to-Combine-Data-from-Tables-with-Different-Granularity/td-p/3661098

-- Podría ser interesante:
-- https://www.ibm.com/docs/en/cognos-analytics/11.1.0?topic=relationships-bridge-tables
-- Agregar por tiempo, pero en este caso igual no tiene sentido.