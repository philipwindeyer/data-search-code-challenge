# frozen_string_literal: true

require 'data_search'
require 'data_search/command_line'

RSpec.describe DataSearch do
  it 'has a version number' do
    expect(DataSearch::VERSION).not_to be nil
  end

  describe '#start' do
    let(:command_line) { instance_double(DataSearch::CommandLine, { run: nil }) }

    before do
      allow(DataSearch::CommandLine).to receive(:new).and_return(command_line)
      DataSearch.start
    end

    it 'instantiates a new command line object' do
      expect(DataSearch::CommandLine).to have_received(:new)
    end

    it 'starts the command line' do
      expect(command_line).to have_received(:run)
    end
  end
end
