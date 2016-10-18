require "spec_helper"
require "shared_context/search_volume"

module KeywordTool
  module SearchVolume
    describe SearchVolume::ApiRequest do
      include_context "search volume"

      subject { described_class.new(request_params) }

      it "gets keywords search volume from the Keyword Toll API" do
        expect(subject.get).to \
          eq(JSON.parse(fake_response, symbolize_keys: true))
      end
    end
  end
end
