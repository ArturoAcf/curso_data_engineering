{% macro nothing_to_null(column_name) %}
    IFF({{column_name}} = '', null, {{column_name}})
{% endmacro %}