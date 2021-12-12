

module ICAP
  require "base36"

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

    return checksum
  end
  
  def self.calculate_bban address
    int = address.delete_prefix("0x").to_i 16
    bban = Base36::encode int
    bban.upcase!

    return bban
  end
  
  def self.calculate_icap bban
    country_code = "XE"
    checksum = calculate_iban_checksum country_code, bban
  
    result = "#{country_code}#{checksum}#{bban}"
    result.gsub!(/(.{4})(?=.)/, '\1 \2')

    return result
  end
  
  def self.extract_address icap
    iban_ws = icap.delete " "  # iban_without_spaces = iban_ws
    bban = iban_ws[4..-1]
    int = Base36.decode bban.downcase
    address_part = int.to_i.to_s 16
    
    return "0x#{"0" * (40 - address_part.length)}#{address_part}"
  end
  
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

