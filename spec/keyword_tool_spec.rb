require 'spec_helper'

describe KeywordTool do
  it 'has a version number' do
    expect(KeywordTool::VERSION).not_to be nil
  end

  context "configuration" do
    let(:api_key) { "my-api-key" }
    let(:endpoint) { "http://api.keywordtool.io/v2" }

    before do
      KeywordTool.configure do |c|
        c.api_key   = api_key
        c.endpoint  = endpoint
      end
    end

    it "has api_key" do
      expect(KeywordTool.api_key).to eq(api_key)
    end

    it "has endpoint" do
      expect(KeywordTool.endpoint).to eq(endpoint)
    end
  end

  context "system" do
    it "have root_path" do
      expect(KeywordTool.root_path).to_not be_nil
    end
  end
end
