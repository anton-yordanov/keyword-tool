require "faraday"

module KeywordTool
  module HTTP
    def self.included(base)
      base.class_eval do
        def http
          http_opt = [{ url: KeywordTool.endpoint }]
          Faraday.new(*http_opt) do |con|
            con.response :logger
            con.adapter  Faraday.default_adapter
          end
        end
      end
    end
  end
end
