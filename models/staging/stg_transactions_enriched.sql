{{ config(
    materialized='incremental', incremental_strategy='merge', unique_key='hash', 
    on_schema_change='sync_all_columns'    ) }}

With token_transfers_aggs as (    
Select 
transaction_hash, 
count(*) as token_transfers_count
from {{ ref('stg_token_transfers') }}
group by transaction_hash),

transactions_enriched as (

Select
t.hash,
t.block_number,
t.date,
t.from_address,
t.to_address,
t.value,
t.receipt_contract_address,
t.input,
tt.token_transfers_count,
1 as new_field,
case
    when t.receipt_contract_address != '' then 'contract_creation'
    when tt.transaction_hash is not null then 'token_transfer'
    when t.input = '0x' and  t.value >0   then 'plain_eth_transfer' 
    else 'other'
end as transaction_category
from {{ ref('stg_transactions') }} t

left join token_transfers_aggs tt
on t.hash = tt.transaction_hash


{% if is_incremental() %}

where t.date > (select max(date) from {{ this }})

{% endif %}
)

Select * from transactions_enriched