# DataSearch

A small command-line app providing the ability to search for, and present, data provided via JSON files. Written in Ruby.

TODO add more info

## Prerequisites

**Note: If you're using a \*nix OS, you likely have all of these installed already and/or can install them via a package manager ([homebrew](https://brew.sh/), [apt](https://packages.debian.org/search?keywords=apt), [yum](http://yum.baseurl.org/), etc)**

- [Git](https://git-scm.com/)
- [Ruby (2.4 or higher)](https://www.ruby-lang.org/en)
- [Bundler](https://bundler.io/) (`gem install bundler`)

## Installation

- Clone this repo: `git clone https://github.com/philipwindeyer/data-search-code-challenge.git`
- `cd data-search-code-challenge`
- Run "setup": `bin/setup` (runs `bundle install`, etc)

## Usage

### From source

- Run `bin/data_search`
- TODO add info on args, etc

### As an executable gem

- Build gem: `gem build data_search.gemspec`
- Install gem: `gem install ./data_search*.gem`
- Run (TODO add instructions on running locally installed gem)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Lint/format your code using RuboCop: `bundle exec rubocop` (`bundle exec rubocop -a` to autocorrect)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
