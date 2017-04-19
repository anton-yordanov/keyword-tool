require "keyword_tool/search_volume/api_request"

module KeywordTool
  module SearchVolume
    END_POINT_PATH = '/search/volume/google'.freeze

    module_function

    def endpoint
      @endpoint ||= KeywordTool.endpoint + END_POINT_PATH
    end

    # @param options Hash[<country:,language:, metrics_location:, metrics_language:>]
    def fetch(options)
      api_req = ApiRequest.new(options)
      api_req.fetch
    end
  end
end
