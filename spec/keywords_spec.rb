require "spec_helper"

module KeywordTool
  describe Keywords do
    let(:keywords) { ["apple", "samsung"] }
    subject { described_class }

    it "store the keywords into the collection" do
      keywords = ["apple", "samsung"]
      collection = subject.new(keywords).collection
      expect(collection).to eq(keywords)
    end

    it "collection size can't be more than #{Keywords::MAX_COLLECTION_SIZE} items" do
      items_number = Keywords::MAX_COLLECTION_SIZE + 1
      keywords = []
      items_number.times { |i| keywords << i }
      expect { subject.new(keywords) }.to raise_error(Keywords::CollectionSizeError)
    end

    it "accepts only array as a argument" do
      keywords = "apple samsung"
      expect { subject.new(keywords) }.to raise_error(ArgumentError)
    end

    it "joins collection to string" do
      keywords = ["apple", "samsung"]
      expect(subject.new(keywords).to_json).to eq(JSON.generate(keywords))
    end

    it "remove unsafe characters from keywords when they are transformed to string" do
      keywords = ["()!?@%,*\n\t\"^={};~`<>?\\|°§ə€£¥￥⁄¶‰′″‴¿–—apple"]
      expect(subject.new(keywords).to_json).to eq("[\"apple\"]")
    end

    it "remove keywords which exceed 80 characters from the JSON" do
      keywords = %W(#{'a'*81} apple samsung)
      sanitized_collection = subject.new(keywords).to_json
      expect(JSON.load(sanitized_collection).size).to eq(2)
    end
  end
end
