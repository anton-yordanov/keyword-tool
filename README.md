# KeywordTool
With this gem  you can fetch the keywords search volume from the
Keywordtool.io API.

More about the Keywordtool.io API can be read [here](https://keywordtool.io/api/documentation)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'keyword_tool'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keyword_tool

## Environment varibles
API_KEY
> Your KeywordTool.io API key


## Usage
  ```ruby
    KeywordTool.configure do |c|
      c.api_key = ENV["API_KEY"]
      c.endpoint = "http://api.keywordtool.io/v2"
    end

    KeywordTool.search_volume(
      keyword: ["keyword1", "keyword1", ...], #array of keywords
      metrics_location: "2840", # Keywordtool.io location code
      output: 'json' # reponse format
    )
  ```

## Testing and debuging
```bash
  bundle exec rspec spec
```

```bash
  bundle exec bin/console
```


## TODO
  - Implement the keyword suggestions API
