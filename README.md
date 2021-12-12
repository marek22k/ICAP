# ICAP
Convert Ethereum addresses and Inter Exchange Client Address Protocol (ICAP) addresses.

Gem, which can create Inter Exchange Client Address Protocol (ICAP) addresses from Ethereum addresses. It can also check the checksum of an ICAP address. It can also restore the Ethereum address from an ICAP address.

Depends on Base36

## Example
```
ICAP::calculate_icap ICAP::calculate_bban "0x000072B1A5F4864C2BA2b14471e48Cc118264794"
  #   => "XE43 9JD3 UD9B FMRC RDS1 IC6B S5MT AQ38"
ICAP::extract_address "XE43 9JD3 UD9B FMRC RDS1 IC6B S5MT AQ38"
  #   => "0x000072B1A5F4864C2BA2b14471e48Cc118264794"
ICAP::check_checksum? "XE43 9JD3 UD9B FMRC RDS1 IC6B S5MT AQ38"
  #   => true
ICAP::calculate_iban_checksum "XE", "09JD3UD9BFMRCRDS1IC6BS5MTAQ38"
  #   => 43
ICAP::calculate_bban "0x000072B1A5F4864C2BA2b14471e48Cc118264794"
  #   => "9JD3UD9BFMRCRDS1IC6BS5MTAQ38"
```

## Inter Exchange Client Address Protocol
Read more on https://eth.wiki/en/ideas/inter-exchange-client-address-protocol-icap
