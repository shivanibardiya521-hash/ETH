
Select 
transaction_hash,
token_address,
value,
date

from {{ source('eth', 'token_transfers') }}