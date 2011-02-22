$:.unshift File.join(File.dirname(__FILE__), '..', 'config')
require 'boot'
require 'currency_spy'

class CurrencyHarvester
  def run
    # Harvest the data
    puts "### Starting the harvest script ###"
    sources = CurrencySource.all
    if sources.count == 0
      puts "No registered currency sources !"
    else
      puts "Registered sources: #{sources.count}\n\n"
      sources.each do |source|
        fetch_data(source) if source.scraper
      end
    end
  end

  protected
  def fetch_data(source)
    puts "Fetching data from #{source.name}"
    scraper = source.scraper.constantize.new
    puts "\tAvailable currencies: #{scraper.available_codes.join(', ')}"
    scraper.available_codes.each do |code|
      scraper.currency_code = code
      # find or create a currency code
      currency_code = prepare_db_code(code)
      # get the response from scraper
      response = scraper.fetch_rates
      # create a CurrencyRate object for given response
      if valid_rate(response)
        create_rate(response, currency_code, source)
      else
        puts "Skipped #{code}: #{response}"
      end
    end
  end

  def valid_rate(response)
    #TODO: implement
    return true
  end

  def create_rate(response, code, source)
    rate = CurrencyRate.new(:currency_code => code, :date => response[:rate_time], :currency_source => source)
    rate.buy_rate = response[:buy_rate]
    rate.sell_rate = response[:sell_rate]
    rate.medium_rate = response[:medium_rate]
    rate.created_at = rate.updated_at = Time.now
    if rate.save!
      puts "Saved: #{rate.currency_code.code} - #{rate.buy_rate} - #{rate.sell_rate} - #{rate.medium_rate}"
    end
    return rate
  end

  def prepare_db_code(code)
    CurrencyCode.ensure_index [[:code, 1]], :unique => true
    CurrencyCode.create(:code => code)
    CurrencyCode.where(:code => code).first
  end
end
CurrencyHarvester.new.run
