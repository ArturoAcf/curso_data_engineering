with 

-- Hay que coger source, porque en la silver de orders hemos cambiado la columna por el ID generado y no existe
source as (

    select shipping_service from {{ source('sql_server_dbo', 'orders') }} 

),

renamed as (

    select
        md5(shipping_service) as shipping_service_id,
        case
            when shipping_service != '' then shipping_service
            else 'no_shipping_service' 
        end as shipping_service_name
    from source
    group by shipping_service
)

select * from renamed
