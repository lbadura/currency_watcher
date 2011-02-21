class CurrencyCode
  include MongoMapper::Document

  key :code, String, :required => true
  many :currency_rates
end
