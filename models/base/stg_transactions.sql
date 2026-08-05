
select
hash,
block_number,
date,
from_address,
to_address,
value,
receipt_contract_address,
input


from {{ source('eth', 'transactions')}}