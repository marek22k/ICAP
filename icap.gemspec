Gem::Specification.new do |spec|
  spec.name        = "icap"
  spec.version     = "1.0.3"
  spec.summary     = "Convert Ethereum addresses and Inter Exchange Client Address Protocol (ICAP) addresses."
  spec.description = "Gem, which can create Inter Exchange Client Address Protocol (ICAP) addresses from Ethereum addresses. It can also check the checksum of an ICAP address. It can also restore the Ethereum address from an ICAP address."
  spec.authors     = ["Marek Kuethe"]
  spec.email       = "m.k@mk16.de"
  spec.files       = ["lib/icap.rb"]
  spec.homepage    = "https://github.com/marek22k/icap"
  spec.license     = "GPL-3.0-or-later"
  spec.add_dependency "base36", ">= 0.1.0"
end
