{# {{ config(
        materialized='incremental',
        unique_key = '_row'
    ) 
}} #}


WITH stg_budget_products AS (
    SELECT * 
    FROM {{ source('google_sheets','budget') }}

    {# {% if is_incremental() %}
        WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }} )
    {% endif %} #}
),

renamed_casted AS (
    SELECT
          _row
        , month
        , quantity 
        , _fivetran_synced
    FROM stg_budget_products
)

SELECT * FROM renamed_casted