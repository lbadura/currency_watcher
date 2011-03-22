module CurrencyWatcher
  class << self
    def boot!
      prepare_loadpaths
      require_dependencies
      require_models
      prepare_db
    end

    def prepare_db
      DataMapper.setup(:default, database_url)
      DataMapper.auto_upgrade!
      DataMapper.finalize
    end

    def database_url
      env = determine_environment
      config_file = YAML.load_file('config/database.yml')
      config = config_file[env.to_s]
      ENV['DATABASE_URL'] || "postgres://#{config['user']}:#{config['password']}@#{config['host']}/#{config['database']}"
    end
    def prepare_loadpaths
      dirs_to_load = ["models", "lib"]
      dirs_to_load.each do |dir_name|
        directory = File.dirname(__FILE__) + "/../#{dir_name}"
        $LOAD_PATH.unshift(directory) unless $LOAD_PATH.include?(directory)
      end
    end

    def require_dependencies
      require 'dm-core'
      require 'dm-migrations'
      require 'dm-timestamps'
      require 'uri'
      require 'yaml'
      require 'ruby-debug' unless production?
    end

    def require_models
      %w(currency_code currency_rate currency_source).each do |name|
        require name
      end
    end

    def production?
      determine_environment == 'production'
    end

    def determine_environment
      ENV['RACK_ENV'] || 'development'
    end
  end
end
CurrencyWatcher.boot!
