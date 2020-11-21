# frozen_string_literal: true

module DataSearch
  # Provides a parser for args provided from command line
  class InputArgParser
    # Parses command-line args (if any), and returns list as an array of strings if "help" was not an arg
    #   If an arg indicates that the help message was requested, the help message is displayed and the app exits
    #
    # @param args [String[]] args from command-line. Default == ARGV
    #
    # @return [String[]] array of file names to pass to the #DataRepository
    #
    # @example Ask parser to pass cmd args using ARGV
    #   file_paths = InputArgParser.new.parse(ARGV)
    def parse(args = ARGV)
      args.each do |arg|
        if ['-h', '--help', 'help'].include?(arg)
          puts HELP
          exit
        end
      end
    end
  end
end
