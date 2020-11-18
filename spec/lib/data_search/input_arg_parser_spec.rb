# frozen_string_literal: true

require 'data_search/input_arg_parser'

module DataSearch
  RSpec.describe InputArgParser do
    describe '#parse' do
      let(:instance) { described_class.new }
      subject { instance.parse(args) }

      before do
        allow(instance).to receive(:exit)
      end

      shared_examples_for 'the help message' do
        it 'prints the help message' do
          expect { subject }.to output(HELP).to_stdout
        end
      end

      describe 'when help requested' do
        context 'by using the -h arg' do
          let(:args) { ['-h'] }

          it_behaves_like 'the help message'
        end

        context 'by using the --help arg' do
          let(:args) { ['--help'] }

          it_behaves_like 'the help message'
        end

        context 'by using the "help" arg' do
          let(:args) { ['help'] }

          it_behaves_like 'the help message'
        end
      end

      describe 'when a single non-help arg is present' do
        let(:args) { ['user.json'] }

        it 'returns array with single arg as a value' do
          expect(subject).to eq(['user.json'])
        end
      end

      describe 'when mutliple args are present' do
        context 'and none are help args' do
          let(:args) { ['organizations.json', 'tickets.json', 'users.json'] }

          it 'returns array with args as a values' do
            expect(subject).to eq(['organizations.json', 'tickets.json', 'users.json'])
          end
        end

        context 'including the -h arg' do
          let(:args) { ['user.json', '-h'] }

          it_behaves_like 'the help message'
        end

        context 'including the --help arg' do
          let(:args) { ['--help', 'organisations.json'] }

          it_behaves_like 'the help message'
        end

        context 'including the "help" arg' do
          let(:args) { ['tickets.json', 'help', 'hodor'] }

          it_behaves_like 'the help message'
        end
      end
    end
  end
end
