# frozen_string_literal: true

require "tty-prompt"
require 'active_support/core_ext/array/conversions'
require 'data_search/command_line_search_methods'

module DataSearch
  class CommandLine
    include CommandLineSearchMethods

    def initialize(data:, prompt: TTY::Prompt.new(interrupt: :signal))
      @prompt = prompt
      @data = data

      Signal.trap("INT") { quit }
    end

    def run
      welcome_prompt
      print_instructions

      loop { main_menu }
    end

    def welcome_prompt
      puts <<~WELCOME

        Welcome to Zendesk Search
        Type 'quit' to exit at any time, Press 'Enter' to continue
      WELCOME

      ask
    end

    def print_instructions
      puts <<-INSTRUCTIONS

        Select search options:
        * Press 1 to search Zendesk
        * Press 2 to view a list of searchable fields
        * Type 'quit' to exit

      INSTRUCTIONS
    end

    def main_menu
      case ask
      when '1'
        search
      when '2'
        print_searchable_fields
      else
        puts 'Your argument is invalid'
      end

      print_instructions
    end

    private

    attr_reader :prompt, :data

    delegate :select, to: :prompt

    def ask(message = nil)
      prompt.ask(message) do |io|
        io.modify :strip, :down
        io.convert ->(input) { quit_command?(input) ? quit : input }
      end
    end

    def quit_command?(input)
      ['quit', 'exit', 'bye'].include?(input)
    end

    def quit
      puts "Bye! 👋\n\n"
      exit
    end
  end
end
