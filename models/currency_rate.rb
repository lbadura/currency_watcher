class CurrencyRate
  include DataMapper::Resource

  property :id, Serial
  property :sell_rate, Float
  property :buy_rate, Float
  property :medium_rate, Float
  property :date, Date, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :currency_source
  belongs_to :currency_code
end
