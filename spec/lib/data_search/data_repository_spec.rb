# frozen_string_literal: true

require 'data_search/json_file_parser'
require 'data_search/data_repository'

module DataSearch
  RSpec.describe DataRepository do
    describe '#new' do
      let(:defaults) { ['organizations.json', 'tickets.json', 'users.json'] }

      describe 'when no file_paths are passed' do
        subject { described_class.new }

        it 'uses the defaults' do
          expect(subject.file_paths).to eq(defaults)
        end
      end

      describe 'when file_paths arg is not an array' do
        subject { described_class.new('ting.json') }

        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError, 'invalid argument')
        end
      end

      describe 'when file_paths arg is an array with nils' do
        subject { described_class.new([nil, nil]) }

        it 'uses the defaults' do
          expect(subject.file_paths).to eq(defaults)
        end
      end
    end

    describe '#data' do
      describe 'with an invalid file' do
        let(:filename) { 'path/to/broken-message.json' }

        subject { described_class.new([filename]).data }

        before do
          allow(JsonFileParser).to receive(:read_data_from_file).and_raise(JSON::ParserError)
        end

        it 'returns array with single object' do
          expect { subject }.to raise_error(JSON::ParserError)
        end
      end

      describe 'with a single, valid file' do
        let(:filename)  { 'path/to/messages.json' }
        let(:test_json) { [{ id: 1, delivered: true, message: 'sup, fam' }] }

        subject { described_class.new([filename]).data }

        before do
          allow(JsonFileParser).to receive(:read_data_from_file).and_return(test_json)
        end

        it 'returns array with single data collection' do
          expect(subject.length).to eq(1)
        end

        describe 'collection in returned array' do
          describe 'when data in file is an array' do
            it 'sets the name to human readable version of file name' do
              expect(subject[0].name).to eq('Messages')
            end

            it 'assigns parsed file contents to "data"' do
              expect(subject[0].data).to eq(test_json)
            end
          end

          describe 'when data in file is a single object' do
            let(:test_json) { { id: 2, delivered: true, message: 'kthxbye' } }

            it 'sets the name to human readable version of file name' do
              expect(subject[0].name).to eq('Messages')
            end

            it 'wraps single object in array and assigns to data' do
              expect(subject[0].data).to eq([test_json])
            end
          end
        end
      end

      describe 'with more than one file' do
        let(:filenames) do
          [
            'path/to/favourite-shows.json',
            'system-settings.json'
          ]
        end

        let(:fav_shows) do
          [
            { id: 1, title: 'breaking bad' },
            { id: 2, title: 'peep show' }
          ]
        end

        let(:system_settings) do
          [
            { name: 'always-show-dock', value: false },
            { name: 'dark-mode', value: true }
          ]
        end

        subject { described_class.new(filenames).data }

        before do
          allow(JsonFileParser).to receive(:read_data_from_file).with(filenames[0]).and_return(fav_shows)
          allow(JsonFileParser).to receive(:read_data_from_file).with(filenames[1]).and_return(system_settings)
        end

        it 'returns array with single object' do
          expect(subject.length).to eq(2)
        end

        describe 'first object' do
          it 'sets the name to human readable version of file name' do
            expect(subject[0].name).to eq('Favourite shows')
          end

          it 'assigns parsed file contents to "data"' do
            expect(subject[0].data).to eq(fav_shows)
          end
        end

        describe 'second object' do
          it 'sets the name to human readable version of file name' do
            expect(subject[1].name).to eq('System settings')
          end

          it 'assigns parsed file contents to "data"' do
            expect(subject[1].data).to eq(system_settings)
          end
        end
      end
    end
  end
end
