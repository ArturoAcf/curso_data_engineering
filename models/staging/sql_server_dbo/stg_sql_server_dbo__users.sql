with 

source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        user_id,
        first_name,
        last_name,
        email,
        coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address,
        phone_number,
        address_id,
        created_at as created_at_utc,
        updated_at as updated_at_utc,
        total_orders,
        _fivetran_deleted,
        _fivetran_synced as date_load_utc

    from source

)

select * from renamed
