# frozen_string_literal: true

module DataSearch
  class InputArgParser
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
