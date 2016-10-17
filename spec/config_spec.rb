require 'spec_helper'

module KeywordTool
  describe Config do
    subject {described_class.new}

    context "api_key" do
      it "has accessor" do
        api_key = "API KEY"
        subject.api_key = api_key
        expect(subject.api_key).to eq(api_key)
      end

      it "raise an error when the value is nil" do
        expect{ subject.api_key }.to \
          raise_error(Config::APIKeyError)
      end
    end

    context "endpoint" do
      it "has default value" do
        expect(subject.endpoint).to eq(Config::DEFAULT_ENDPOIN)
      end

      it "value can be changed" do
        new_api_endpoint = "http://api.keywordtool.io/v3"
        subject.endpoint = new_api_endpoint
        expect(subject.endpoint).to eq(new_api_endpoint)
      end
    end
  end
end
