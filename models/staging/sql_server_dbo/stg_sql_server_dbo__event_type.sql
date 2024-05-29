with 

-- Hay que coger source, porque en la silver de orders hemos cambiado la columna por el ID generado y no existe
source as (

    select event_type from {{ source('sql_server_dbo', 'events') }} 

),

renamed as (

    select
        md5(event_type) as event_type_id,
        event_type
    from source
    group by event_type
)

select * from renamed
