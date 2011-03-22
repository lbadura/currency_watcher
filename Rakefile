$:.unshift File.dirname(__FILE__)
require 'rake'
require 'config/boot'

namespace :setup do
  desc "Seeds the database with all required currency_sources"
  task :sources do
    sources = [['NBP', 'CurrencySpy::Nbp'],
      ['DnB Nord','CurrencySpy::DnbNord'],
      ['Walutomat','CurrencySpy::Walutomat']].freeze

    sources.each do |source|
      CurrencySource.first_or_create(:name => source[0], :scraper => source[1])
    end
  end
end

namespace :data do
  desc "Fetch currency rates from known sources"
  task :harvest do
    require 'currency_spy'
    require 'currency_harvester'
    CurrencyHarvester.new.run
  end
end
