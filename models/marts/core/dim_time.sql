{{
    config(
        materialized="table"
    )
}}
{{ dbt_date.get_date_dimension("2015-01-01", "2024-05-28") }}