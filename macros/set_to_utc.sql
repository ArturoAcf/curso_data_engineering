{% macro set_to_utc(column_name) %}
    CONVERT_TIMEZONE( 'UTC', TO_TIMESTAMP_TZ({{column_name}}) )
{% endmacro %}
