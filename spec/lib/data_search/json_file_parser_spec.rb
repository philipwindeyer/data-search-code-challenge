# frozen_string_literal: true

require 'data_search/json_file_parser'

module DataSearch
  RSpec.describe JsonFileParser do
    describe '#read_data_from_file' do
      describe 'file path arg' do
        describe 'when file path is not provided as first arg' do
          it 'raises an ArgumentError' do
            expect { described_class.read_data_from_file }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)')
          end
        end

        describe 'when file path arg provided is nil' do
          it 'raises an ArgumentError' do
            expect { described_class.read_data_from_file(nil) }.to raise_error(ArgumentError, 'invalid argument')
          end
        end

        describe 'when file path provided does not match a file' do
          it 'raises an ArgumentError' do
            expect { described_class.read_data_from_file('123.json') }.to raise_error(Errno::ENOENT, /No such file or directory/)
          end
        end

        describe 'when file path provided does not look like a string' do
          it 'raises an ArgumentError' do
            expect { described_class.read_data_from_file(DataSearch::JsonFileParser) }.to raise_error(TypeError)
          end
        end
      end

      describe 'when file path is valid' do
        describe 'but the file does not contain JSON' do
          let(:filename) { 'hodor.json' }

          before { File.write(filename, 'hodor') }
          after  { File.delete(filename) }

          it 'raises a ParserError' do
            expect { described_class.read_data_from_file(filename) }.to raise_error(JSON::ParserError)
          end
        end

        describe 'but the file contains malformed JSON' do
          let(:filename) { 'sad.json' }

          before { File.write(filename, '{"sad":true,name:oldmate}') }
          after  { File.delete(filename) }

          it 'raises a ParserError' do
            expect { described_class.read_data_from_file(filename) }.to raise_error(JSON::ParserError)
          end
        end

        describe 'and the file contains valid JSON' do
          let(:filename) { 'happy.json' }
          let(:expected) { { sad: false, name: 'fren', greeting: 'henlo' } }

          before { File.write(filename, '{"sad":false,"name":"fren","greeting":"henlo"}') }
          after  { File.delete(filename) }

          it 'returns a hash object representing the JSON data in the file provided' do
            expect(described_class.read_data_from_file(filename)).to eq(expected)
          end
        end
      end
    end
  end
end
