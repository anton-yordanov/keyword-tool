require "spec_helper"

module KeywordTool
  describe Locations do
    context "fetch al locations" do
      let(:locations) { Locations.all }

      it "return hash with all locations" do
        expect(locations).to be_kind_of(Hash)
      end

      it "hash keys are country names and the values are country codes" do
        expect(locations["Sweden"]).to eq({ code: 2752, country_code: "SE" })
      end
    end

    context "find locations by criteria" do
      let(:name) { "Sweden" }
      it "return location hash" do
        expect(Locations.find_by_name(name)).to eq({ "Sweden" => {code: 2752,
                                                    country_code: "SE"}})
      end
    end
  end
end
