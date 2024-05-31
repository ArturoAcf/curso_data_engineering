{% macro nothing_to_null(column_name) %}
    IFF({{column_name}} = '', null, {{column_name}})
{% endmacro %}

-- https://discourse.getdbt.com/t/how-do-we-pass-column-values-into-dbt-macros/9782