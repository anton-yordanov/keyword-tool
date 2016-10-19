# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keyword_tool/version'

Gem::Specification.new do |spec|
  spec.name          = "keyword_tool"
  spec.version       = KeywordTool::VERSION
  spec.authors       = ["Anton Yordanov"]
  spec.email         = ["anton.yordanov@comstream.se"]

  spec.summary       = %q{Get the keyowrd search volume and suggestions from Keyword Tool API}
  spec.description   = %q{Get Google search volume data and autocomplete keyword suggestionsfor for your keywords using Keyword Tool API}
  spec.homepage      = "https://github.com/anton-yordanov"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9.2"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "gem-ctags"
  spec.add_development_dependency "dotenv"
end
