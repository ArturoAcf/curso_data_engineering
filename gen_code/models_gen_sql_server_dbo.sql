{% set models_to_generate = codegen.get_models(directory='models/staging/sql_server_dbo', prefix='stg_') %}
{{ codegen.generate_model_yaml(
    model_names = ['stg_sql_server_dbo__addresses','stg_sql_server_dbo__events','stg_sql_server_dbo__order_items','stg_sql_server_dbo__orders','stg_sql_server_dbo__products','stg_sql_server_dbo__promos','stg_sql_server_dbo__users']
) }}