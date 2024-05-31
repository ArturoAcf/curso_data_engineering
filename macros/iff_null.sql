{% macro iff_null(column_name) %}

{% set query %}

  select 
       iff(column_name = '', null, column_name) as {{ column_name }}
{% endset %}

{% set results = run_query(query) %}

{%endmacro%}