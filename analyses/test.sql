
-- Select 
-- {{dbt_utils.star(from = ref('stg_transactions_enriched'), except=['new_field'], quote_identifiers=False,prefix='stg_')}}
-- from {{ ref('stg_transactions_enriched') }} 

{{audit_helper.compare_relations(source ('eth', 'contracts'),  source ('eth', 'contracts_clone')) }}