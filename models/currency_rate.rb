class CurrencyRate
  include MongoMapper::Document

  key :sell_rate, Float
  key :buy_rate, Float
  key :medium_rate, Float
  key :date, Date, :required => true
  key :created_at, DateTime
  key :updated_at, DateTime

  belongs_to :currency_source
  belongs_to :currency_code
end
