$:.unshift File.join(File.dirname(__FILE__), '..', 'config')
require('boot')

# Harvest the data
puts "### Starting the harvest script ###"
sources = CurrencySource.all
if sources.count == 0
  puts "No registered currency sources !"
else
  puts "Registered sources: #{sources.count}"

  sources.each do |source|
    puts "Fetching data from #{source.name}"
    #scraper = source.parser
    #if scraper
      #scraper.available_codes.each do |code|
        #sell_rate, buy_rate, time = scraper.fetch_for_code(code)
        #puts "Code: #{code}, Time: #{time}, Rate: #{rate}"
        #cc = CurrencyCode.first(:code => code)
        #cr = CurrencyRate.first_or_create(:currency_code => cc, :date => time, :currency_source => source)
        #cr.sell_rate = sell_rate
        #unless buy_rate.nil?
          #cr.buy_rate = buy_rate
        #end
        #cr.created_at = cr.updated_at = Time.now
        #cr.save
      #end
    #else
      #next
    #end
  end
end
