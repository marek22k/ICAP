

module ICAP
  require "base36"

  # Calculates the checksum of an IBAN
  #
  # Example:
  #   >> ICAP::calculate_iban_checksum "XE", "09JD3UD9BFMRCRDS1IC6BS5MTAQ38"
  #   => 43
  #
  # Arguments:
  #   country_code: (String)
  #   bban: (String)
  def self.calculate_iban_checksum country_code, bban
    checksum = "00"

    prepared_iban = "#{bban}#{country_code}#{checksum}"
    number = ""
    prepared_iban.each_char { |c|
      if ('A'..'Z').to_a.include? c
        number += (c.ord - "A".ord + 10).to_s
      else
        number += c
      end
    }
    checksum = 98 - (number.to_i % 97)
    checksum = checksum.to_s
    checksum = "0#{checksum}" if checksum.length == 1

    return checksum
  end
  
  # Calculates the BBAN of an ICAP from the Ethereum address
  #
  # Example:
  #   >> ICAP::calculate_bban "0x000072B1A5F4864C2BA2b14471e48Cc118264794"
  #   => "9JD3UD9BFMRCRDS1IC6BS5MTAQ38"
  #
  # Arguments:
  #   address: (String)
  def self.calculate_bban address
    int = address.delete_prefix("0x").to_i 16
    bban = Base36::encode int
    bban.upcase!

    return bban
  end
  
  # Calculates the ICAP from BBAN
  #
  # Example:
  #   >> ICAP::calculate_icap ICAP::calculate_bban "0x000072B1A5F4864C2BA2b14471e48Cc118264794"
  #   => "XE43 9JD3 UD9B FMRC RDS1 IC6B S5MT AQ38"
  #
  # Arguments:
  #   bban: (String)
  def self.calculate_icap bban
    country_code = "XE"
    checksum = calculate_iban_checksum country_code, bban
  
    result = "#{country_code}#{checksum}#{bban}"
    result.gsub!(/(.{4})(?=.)/, '\1 \2')

    return result
  end
  
  # Extracts the Ethereum address from an ICAP. The checksum is not checked.
  #
  # Example:
  #   >> ICAP::extract_address "XE43 9JD3 UD9B FMRC RDS1 IC6B S5MT AQ38"
  #   => "0x000072B1A5F4864C2BA2b14471e48Cc118264794"
  #
  # Arguments:
  #   icap: (String)
  def self.extract_address icap
    iban_ws = icap.delete " "  # iban_without_spaces = iban_ws
    bban = iban_ws[4..-1]
    int = Base36.decode bban.downcase
    address_part = int.to_i.to_s 16
    
    return "0x#{"0" * (40 - address_part.length)}#{address_part}"
  end
  
  # Checks the checksum.
  #
  # Example:
  #   >> ICAP::check_checksum? "XE43 9JD3 UD9B FMRC RDS1 IC6B S5MT AQ38"
  #   => true
  #
  # Arguments:
  #   iban: (String)
  def self.check_checksum? iban
    iban_ws = iban.delete " "  # iban_without_spaces = iban_ws
    prepared_iban = "#{iban_ws[4..-1]}#{iban_ws[0...4]}"
    
    number = ""
    prepared_iban.each_char { |c|
      if ('A'..'Z').to_a.include? c
        number += (c.ord - "A".ord + 10).to_s
      else
        number += c
      end
    }
    
    result = number.to_i % 97
    
    return result == 1
  end
end

