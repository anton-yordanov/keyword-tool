require "json"
require "keyword_tool/http"
require "keyword_tool/keywords"

module KeywordTool
  module SearchVolume
    class ApiRequest
      include KeywordTool::HTTP

      class MissingKeywordParameterError < StandardError; end

      PERMITED_PARAMS =
        %i("country language metrics_location metrics_language
            keyword metrics_network metrics_currency output").freeze

      attr_reader :params

      def initialize(params)
        @params = params
      end

      def fetch
        payload = permited_parameters.merge(apikey: KeywordTool.api_key)
        response =
          http.post do |req|
            req.url(SearchVolume.endpoint)
            req.options.timeout = 90
            req.options.open_timeout = 30
            req.headers["Accept"] = "application/json"
            req.body = payload
          end

        JSON.parse(response.body, symbolize_keys: true)
      end

      private

      def permited_parameters
        return @permited_parameters if @permited_parameters

        unless params[:keyword]
          raise(MissingKeywordParameterError, "keyword is required parameter")
        end

        params[:keyword] = KeywordTool::Keywords.new(params[:keyword]).to_json

        @permited_parameters =
          params.keep_if do |key, _|
            PERMITED_PARAMS.include?(key)
          end
      end
    end
  end
end
