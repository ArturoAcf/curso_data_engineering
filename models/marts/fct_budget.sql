WITH stg_budget_products AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets__budget') }}
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