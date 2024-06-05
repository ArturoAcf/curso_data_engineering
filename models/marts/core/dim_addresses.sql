with 

source as (

    select * from {{ ref('stg_sql_server_dbo__addresses') }}

),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        date_load_utc

    from source

)

select * from renamed
