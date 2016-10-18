module KeywordTool
  class Config
    class APIKeyError < StandardError;end
    DEFAULT_ENDPOIN = "http://api.keywordtool.io/v2".freeze

    attr_accessor :api_key
    attr_accessor :endpoint

    # @return [String] Keyword Tool API Key
    def api_key
      raise(APIKeyError, "Missing API key") unless @api_key
      @api_key
    end

    # @return [String] Keyword Tool API endpoint
    def endpoint
      @endpoint ||= DEFAULT_ENDPOIN
    end
  end
end
