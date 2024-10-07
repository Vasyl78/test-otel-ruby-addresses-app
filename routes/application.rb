# frozen_string_literal: true

module Routes
  # Routes::Application
  class Application < ::Roda
    opts[:root] = ENV.fetch('APP_ROOT', nil)
    plugin :all_verbs
    plugin :symbol_status
    plugin :json, content_type: 'application/vnd.api+json'
    plugin :json_parser
    plugin :slash_path_empty
    plugin :hash_routes
    plugin :request_headers

    # use Middlewares::RackMiddleware

    route do |req|
      req.on('addresses') do
        req.is('find-by', method: :get) do
          uuid = req.params['uuid']
          address_data = Utils::RedisStorage.get(uuid)

          unless address_data.is_a?(Hash)
            address_data = {
             zip_code:        FFaker::AddressUS.zip_code,
             city:            FFaker::AddressUS.city,
             street_name:     FFaker::AddressUS.street_name,
             building_number: FFaker::AddressUS.building_number
            }

            Utils::RedisStorage.set(uuid, address_data)
          end

          response.status = 200
          address_data
        end
      end
    end
  end
end
