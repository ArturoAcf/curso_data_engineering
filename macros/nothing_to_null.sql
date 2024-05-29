{% macro nothing_to_null(columna) %}
    ({{ column_name }} / 100)::numeric(16, {{ scale }})
{% endmacro %}
