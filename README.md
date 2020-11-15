# DataSearch

A small command-line app providing the ability to search for, and present, data provided via JSON files. Written in Ruby.

The aim of this code base is to satisfy the requirements of a code challenge.

The app assumes that there are 3 JSON files in the root of the project (provided by assessor), and that the app is run from the project root dir, using the `data_search` script in `bin/` (i.e. `bin/data_search`).

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

Once set up, the app can be run from source.

From the root of the project directory, run:

- `bin/data_search`

Instructions are displayed during the use of the application.

## Development

### Setting up

After checking out the repo;

- Run `bin/setup`, to install dependencies (i.e. setup does a `bundle install`, etc)

### Practises

The app structure conforms to the standard structure (scaffold) of any ordinary Ruby Gem.

For each lib file, there is a corresponding Rspec suite in the `spec/` directory.

Testing should be thorough, and styling/linting used to keep the codebase neat.

- `bundle exec rubocop` to run rubocop over the entire codebase (suffix `-a` or `-A` to autocorrect)
- `bundle exec rspec` to run the spec suite

You can also experiment via IRB (with lib resources loaded) using;

- `bin/console`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
