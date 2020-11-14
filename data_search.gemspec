# frozen_string_literal: true

require_relative 'lib/data_search/version'

Gem::Specification.new do |spec|
  spec.name          = 'data_search'
  spec.version       = DataSearch::VERSION
  spec.authors       = ['Philip Windeyer']
  spec.email         = ['philipwindeyer@gmail.com']

  spec.summary       = '"Data Search" code challenge for Zendesk'
  spec.description   = 'A command-line app providing the ability to search for and present data provided via JSON files'
  spec.homepage      = 'https://github.com/philipwindeyer/data-search-code-challenge'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # TODO: Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
