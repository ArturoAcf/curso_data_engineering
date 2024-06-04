{# -- TIMESTAMP

-- {% snapshot budget_snapshot %}

-- {{
--     config(
--       target_schema='snapshots',
--       unique_key='_row',
--       strategy='timestamp',
--       updated_at='_fivetran_synced',
--     )
-- }}

-- select * from {{ source('google_sheets', 'budget') }}

-- {% endsnapshot %} #}


-- CHECK

{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='_row',
      strategy='check',
      check_cols=['quantity'],
        )
}}

select * from {{ source('google_sheets', 'budget') }}

{% endsnapshot %}