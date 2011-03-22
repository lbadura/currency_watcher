class CurrencyCode
  include DataMapper::Resource

  property :id, Serial
  property :code, String, :required => true
  has n, :currency_rates
end
