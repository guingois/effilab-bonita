module Bonita
  class Client
    attr_reader :username, :password, :url, :redirect_url, :tenant

    class << self
      def resources
        {
          processes: Bpm::ProcessResource,
        }
      end

      def start(options = {})
        client = new(options)
        client.login!

        if block_given?
          begin
            yield(client)
          ensure
            client.logout!
          end
        end

        client
      end
    end

    self.resources.each do |k, v|
      define_method(k) { v.new(connection: connection) }
    end

    def initialize(options = {})
      @url          = options[:url]
      @username     = options[:username]
      @password     = options[:password]
      @redirect_url = options[:redirect_url]
      @tenant       = options[:tenant]
    end

    def login!
      connection.post '/bonita/loginservice' do |req|
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = { username: @username, password: @password, redirect_url: @redirect_url, tenant: @tenant }
      end
    end

    def logout!
      connection.get '/bonita/logoutservice'
    end

    def connection
      @faraday ||=
        Faraday.new connection_options do |conn|
          conn.use :cookie_jar
          conn.use Bonita::Middleware::CSRF
          conn.use Faraday::Request::UrlEncoded
          conn.adapter Faraday.default_adapter
        end
    end

    private

      def connection_options
        {
          url: @url,
          request: {
            params_encoder: Faraday::FlatParamsEncoder,
          },
          headers: {
            content_type: 'application/json',
          },
        }
      end
  end
end
