module CurrencyWatcher
  class << self
    def boot!
      prepare_loadpaths
      require_dependencies
      require_models
      prepare_db
    end

    def prepare_db
      env = determine_environment
      if [:development, :test].include?(env)
        config_file = YAML.load_file('config/database.yml') 
        config = config_file[env.to_s]
        MongoMapper.connection = Mongo::Connection.new(config['hostname'])
        MongoMapper.database = config['database']
      else
        uri = URI.parse(ENV['MONGOHQ_URL'])
        conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
        db = conn.db(uri.path.gsub(/^\//, ''))
      end
    end

    def prepare_loadpaths
      dirs_to_load = ["models", "lib"]
      dirs_to_load.each do |dir_name|
        directory = File.dirname(__FILE__) + "/../#{dir_name}"
        $LOAD_PATH.unshift(directory) unless $LOAD_PATH.include?(directory)
      end
    end

    def require_dependencies
      require 'mongo'
      require 'mongo_mapper'
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
      determine_environment == :production
    end

    def determine_environment
      if defined?(settings)
        return settings.environment unless settings.environment.nil?
      else
        return :development
      end
    end
  end
end
CurrencyWatcher.boot!
