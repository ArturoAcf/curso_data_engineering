with 

source as (

    select * from {{ ref('stg_sql_server_dbo__order_status') }} 

),

renamed as (

    select
        order_status_id,
        order_status
    from source
)

select * from renamed
