module MovieApp
  require 'sequel'
  # DB = Sequel.connect("mysql2://root@localhost:3306/besepa-stats", logger: Logger.new(STDOUT))
  class App
    def initialize
    end

    def self.instance
      @instance ||= Rack::Builder.new do

        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any, methods: [:get, :post, :patch, :delete]
          end
        end

        run MovieApp::App.new
      end.to_app
    end

    def call(env)
      # api
      response = Base::API.call(env)

      # Check if the App wants us to pass the response along to others
      return response

      # Serve error pages or respond with API response
      
    end
  end
end