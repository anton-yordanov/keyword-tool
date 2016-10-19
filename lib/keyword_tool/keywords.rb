module KeywordTool
  class Keywords
    UNSAFE_CHARACTERS =
      Regexp.escape("-()!?@%,*\n\t\"^={};~`<>?\\|°§ə€£¥￥⁄¶‰′″‴¿–—").freeze
    MAX_COLLECTION_SIZE = 800

    class CollextionSizeError < StandardError; end

    attr_reader :collection

    def initialize(collection)
      if collection.size > MAX_COLLECTION_SIZE
        raise(CollextionSizeError,
          "Collection size is biger than #{MAX_COLLECTION_SIZE}")
      end

      raise(ArgumentError,
        "keywords must be an array") unless collection.is_a?(Array)

      @collection = collection
    end

    def to_s
      "[#{sanitize.join(',')}]"
    end

    private

    def sanitize
      collection.each do |keyowrd|
        keyowrd.gsub!(/[#{UNSAFE_CHARACTERS}]/, '')
      end
    end
  end
end
