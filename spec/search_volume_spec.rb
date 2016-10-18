require "spec_helper"
require "shared_context/search_volume"

module KeywordTool
  describe SearchVolume do
    include_context "search volume"

    it "gets keywords search volume from the Keyword Toll API" do
      expect(SearchVolume.get(request_params)).to \
        eq(JSON.parse(fake_response, symbolize_keys: true))
    end
  end
end