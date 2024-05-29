SELECT *
FROM {{ ref('stg_sql_server_dbo__orders') }}
WHERE estimated_delivery_at_utc < created_at_utc
-- A