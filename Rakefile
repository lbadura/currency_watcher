$:.unshift File.dirname(__FILE__)
require 'rake'
require 'config/boot'

namespace :setup do
  desc "Seeds the database with all required currency_sources"
  task :sources do
    CurrencySource.first_or_create(:name => 'NBP', :scraper => 'CurrencySpy::Nbp')
    CurrencySource.first_or_create(:name => 'DnB Nord', :scraper => 'CurrencySpy::DnbNord')
    CurrencySource.first_or_create(:name => 'Walutomat', :scraper => 'CurrencySpy::Walutomat')
  end
end
