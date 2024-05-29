with users as (

    select * from {{ ref('stg_sql_server_dbo__users') }}

),
    
validate_users_email as (

    select
        user_id
        first_name,
        last_name,
        email,
        coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address
    from users

)

select * from validate_users_email