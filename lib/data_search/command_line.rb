# frozen_string_literal: true

require "tty-prompt"
require 'active_support/core_ext/array/conversions'
require 'data_search/command_line_search_methods'

module DataSearch
  # Provides a basic interactive command-line to interact with (i.e. search) data
  class CommandLine
    include CommandLineSearchMethods

    # @param data [DataCollection[]] collections of searchable data
    #
    # Instantiates command-line, a @see TTY::Prompt to capture input,
    #   and traps SIGINT (ctrl+c) signals for a graceful shutdown of the app
    def initialize(data:, prompt: TTY::Prompt.new(interrupt: :signal))
      @prompt = prompt
      @data = data

      Signal.trap("INT") { quit }
    end

    # Starts interactive command prompt, with the "welcome message" and "instructions"
    def run
      welcome_prompt
      loop { main_menu }
    end

    def welcome_prompt
      puts WELCOME
      ask
    end

    def print_instructions
      puts INSTRUCTIONS
    end

    def main_menu
      print_instructions

      case ask
      when '1'
        search
      when '2'
        print_searchable_fields
      else
        puts 'Your argument is invalid'
      end
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
