class CurrencySource
  include MongoMapper::Document

  key :name, String, :required => true
  key :scraper, String, :required => true
  key :created_at, DateTime
  key :updated_at, DateTime

  many :currency_rates

end
