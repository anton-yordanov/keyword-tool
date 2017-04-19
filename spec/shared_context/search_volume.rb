RSpec.shared_context "search volume", :shared_context => :metadata do
  before do
    KeywordTool.configure do |c|
      c.api_key = ENV["API_KEY"]
    end

    stub_request(:post, /#{KeywordTool::SearchVolume.endpoint}/)
      .to_return(body: fake_response)
  end

  let(:request_params) do
    { keyword: %w("apple samsung") }
  end

  let(:fake_response) do
    json_path =
      "#{KeywordTool.root_path}/spec/fixtures/fake_search_volume_response.json"
    File.read(json_path, encoding: "UTF-8")
  end
end
