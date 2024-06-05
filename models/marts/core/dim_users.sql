with 

source as (
    select * from {{ ref('stg_sql_server_dbo__users') }}
),

renamed as (
    select
        user_id,
        first_name,
        last_name,
        email,
        is_valid_email_address,
        phone_number,
        address_id,
        created_at_utc,
        updated_at_utc,
        -- total_orders,
        _fivetran_deleted,
        date_load_utc
    from source
)

select * from renamed
