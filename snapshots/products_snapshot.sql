{% snapshot products_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
        )
}}

select * from {{ source('sql_server_dbo', 'products') }}
{# where _fivetran_synced > (select max(_fivetran_synced) from {{ this }}) #}

{% endsnapshot %}
