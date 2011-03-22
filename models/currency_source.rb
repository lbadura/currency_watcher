class CurrencySource
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :scraper, String, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :currency_rates
end
