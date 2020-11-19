# DataSearch

A small command-line app providing the ability to search for, and present, data provided via JSON files. Written in Ruby.  
The aim of this code base is to satisfy the requirements of a code challenge.

The code challenge solution in question has also been written in TypeScript [here](https://github.com/philipwindeyer/data-search-code-challenge-ts) (although this versio differs significantly). (TODO: link to TS version once ready)

It is generic in nature, in that any valid JSON file(s) can be used as the data source to search over. If no file args are provided when running the app, default data is used (see the 3 .json files in the root dir).

For a domain-specific version of the app (assuming the searchable domains "Organisation", "User" and "Ticket"), see my [TypeScript version here](https://github.com/philipwindeyer/data-search-code-challenge-ts).

The app is run from the project root dir, using the `data_search` script in `bin/` (i.e. `bin/data_search`).

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
For each lib file, there is a corresponding RSpec suite in the `spec/` directory.

#### Rubocop (linting/formatting)

- `bundle exec rubocop` to run rubocop over the entire code base (suffix `-a` or `-A` to autocorrect)

Rubocop, along with the [Relaxed Ruby Style](https://relaxed.ruby.style/) config, is used to lint/analyze the code base, and format.

The relaxed style config provides clean "best practise" rules, without the overarching hardcore rule-set of the default rubocop config.  
It also provides formatting rules to trim any white space, and correct indents where necessary.

#### RSpec (testing)

- `bundle exec rspec` to run the spec suite

Components of the app are all unit tested with RSpec test suites, located in `spec/`.

#### RDoc

TODO Fill this in

#### IRB (console)

- `bin/console` to load up IRB with gem files present.

You can also experiment via IRB (with lib resources loaded) if needed.

## Issues and To-dos

See [Issues](https://github.com/philipwindeyer/data-search-code-challenge/issues) for outstanding work, and any issues/bugs that require addressing

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
