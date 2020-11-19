# frozen_string_literal: true

module DataSearch
  WELCOME = <<~WELCOME

    Welcome to Zendesk Search
    Type 'quit' to exit at any time, Press 'Enter' to continue
  WELCOME

  INSTRUCTIONS = <<-INSTRUCTIONS

        Select search options:
        * Press 1 to search Zendesk
        * Press 2 to view a list of searchable fields
        * Type 'quit' to exit

  INSTRUCTIONS

  HELP = <<~HELP

    Zendesk search app
    Provides the ability to search data provided via JSON files

    Usage: bin/data_search [args]
      <no args>                 Run app with defaults
      -h, --help, help          Displays this message
      [<file.json>...]          Provide 1..* json files to search (defaults used if no file args provided)

    Examples:
      bin/data_search -h
      bin/data_search help
      bin/data_search users.json
      bin/data_search users.json examples/doggos.json examples/moar_data.json

  HELP
end
