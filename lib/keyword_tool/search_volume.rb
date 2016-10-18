require "keyword_tool/search_volume/api_request"

module KeywordTool
  module SearchVolume
    END_POINT_PATH = '/search/volume/google'.freeze

    module_function

    def endpoint
      @endpoint ||= KeywordTool.endpoint + END_POINT_PATH
    end

    def get(params)
      api_req = ApiRequest.new(params)
      api_req.get
    end
  end
end
