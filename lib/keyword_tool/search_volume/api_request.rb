require "json"
require "keyword_tool/http"

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

      def get
        reponse =
          http.get do |req|
            req.url(
              SearchVolume.endpoint,
              permited_parameters.merge(apikey: KeywordTool.api_key)
            )
            req.options.timeout = 30
            req.options.open_timeout = 5
            req.headers = { "Accept" => "application/json" }
          end.body

        JSON.parse(reponse, symbolize_keys: true)
      end

      private

      def permited_parameters
        return @permited_parameters if @permited_parameters

        unless params[:keyword]
          raise(MissingKeywordParameterError, "keyword is required parameter")
        end

        params[:keyword] = "[#{params[:keyword].join(',')}]"

        @permited_parameters =
          params.keep_if do |key, _|
            PERMITED_PARAMS.include?(key)
          end
      end
    end
  end
end
