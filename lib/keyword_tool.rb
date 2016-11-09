require "keyword_tool/version"
require "keyword_tool/config"
require "keyword_tool/search_volume"

module KeywordTool
  ##
  # @example Configure takes block to set API key and API endpoint to be used in API calls.
  #
  #    KeywordTool.configure do |c|
  #      c.api_key = 'my-key'
  #      c.endpoint = 'http://api.endpoint.io/v3/'
  #    end

  def self.method_missing(method_sym, *arguments, &block)
    configure.send(method_sym)
  rescue
    super
  end

  def self.respond_to?(method_sym, include_private = false)
    return true if configure && configure.repond_to?(method_sym)
    super
  end

  module_function

  def configure
    return yield(@config = Config.new) if block_given?
    @config
  end

  def root_path
    @root_path ||= File.expand_path("../../", __FILE__)
  end

  ##
  # @example
  #   KeywordTool.search_volume(keyword: ["samsung", "apple", "andorid"], metrics_location: "2840")

  def search_volume(params)
    SearchVolume.get(params)
  end
end
