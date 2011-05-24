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

  def spread
    if sell_rate.nil? || buy_rate.nil?
      "b/d"
    else
      (sell_rate - buy_rate)
    end
  end
end
