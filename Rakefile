$:.unshift File.dirname(__FILE__)
require 'rake'
require 'config/boot'

namespace :setup do
  desc "Seeds the database with all required currency_sources"
  task :sources do
    CurrencySource.ensure_index [[:name, 1],[:scraper, 1]], :unique => true
    time = Time.now
    CurrencySource.create(:name => 'NBP', :scraper => 'CurrencySpy::Nbp', :created_at => time, :updated_at => time)
    CurrencySource.create(:name => 'DnB Nord', :scraper => 'CurrencySpy::DnbNord', :created_at => time, :updated_at => time)
    CurrencySource.create(:name => 'Walutomat', :scraper => 'CurrencySpy::Walutomat', :created_at => time, :updated_at => time)
  end
end
