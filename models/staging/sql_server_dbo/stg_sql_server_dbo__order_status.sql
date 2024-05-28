with 

-- Hay que coger source, porque en la silver de orders hemos cambiado la columna por el ID generado y no existe
source as (

    select status from {{ source('sql_server_dbo', 'orders') }} 

),

renamed as (

    select
        md5(status) as order_status_id,
        status as order_status
    from source
    group by status
)

select * from renamed
