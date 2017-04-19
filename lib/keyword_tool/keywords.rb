require "json"
module KeywordTool
  class Keywords
    UNSAFE_CHARACTERS =
      Regexp.escape("()!?@%,*\n\t\"^={};~`<>\\|°§ə€£¥￥⁄¶‰′″‴¿–—").freeze
    MAX_COLLECTION_SIZE = 800

    class CollectionSizeError < StandardError; end

    attr_reader :collection

    def initialize(collection)
      if collection.size > MAX_COLLECTION_SIZE
        raise(CollectionSizeError,
          "Collection size is more than #{MAX_COLLECTION_SIZE}")
      end

      raise(ArgumentError,
        "keywords must be an array") unless collection.is_a?(Array)

      @collection = collection
    end

    def to_json
      JSON.generate(sanitized_collection)
    end

    private

    def sanitized_collection
      collection.each do |keyowrd|
        keyowrd.gsub!(/[#{UNSAFE_CHARACTERS}]/, '')
      end
    end
  end
end
