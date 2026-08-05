{% macro random_macro() %}

{% set query %}

select distinct
token_address
from {{ ref('stg_token_transfers') }}
limit 10

{% endset %}

{% if execute %}

{% set result = run_query(query) %}

{% set result_list = result.columns[0].values() %}
{% else %}

{% set result_list = [] %}

{% endif %}

{{ log(result_list, info=True) }}

{{ return(result_list) }}

{% endmacro %} 