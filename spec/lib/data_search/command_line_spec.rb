# frozen_string_literal: true

require 'data_search/command_line'

module DataSearch
  RSpec.describe CommandLine do
    let(:data) do
      [
        DataCollection.new(
          'Frens', [
            {
              id: 1,
              name: 'Bruce',
              type: 'Ket',
              breed: 'Ragdoll'
            },
            {
              id: 2,
              name: 'Kerrie',
              type: 'Doggo',
              breed: 'Staffy'
            }
          ]
        ),
        DataCollection.new(
          'Treats', [
            {
              id: 1,
              name: 'Liver Strips'
            }
          ]
        )
      ]
    end

    let(:prompt) { instance_double(TTY::Prompt, ask: nil, select: nil) }

    subject { described_class.new(data: data, prompt: prompt) }

    def get_expected_output(arr)
      arr.append('').join("\n")
    end

    describe '#initialize' do
      before do
        allow(TTY::Prompt).to receive(:new).with(interrupt: :signal)
        allow(Signal).to receive(:trap).with('INT')
        described_class.new(data: data)
      end

      it 'trap SIGINT (Ctrl+C) signals' do
        expect(Signal).to have_received(:trap).with('INT')
      end

      it 'raises an error if the data arg is missing' do
        expect { described_class.new }.to raise_error(ArgumentError)
      end

      it 'sets the prompt to TTY::Prompt by default' do
        expect(TTY::Prompt).to have_received(:new).with(interrupt: :signal)
      end
    end

    describe '#welcome_prompt' do
      let(:expected_output) do
        get_expected_output(
          [
            "",
            "Welcome to Zendesk Search",
            "Type 'quit' to exit at any time, Press 'Enter' to continue",
          ]
        )
      end

      it 'prints the welcome message' do
        expect { subject.welcome_prompt }.to output(expected_output).to_stdout
      end

      it 'prompts for input' do
        subject.welcome_prompt
        expect(prompt).to have_received(:ask)
      end
    end

    describe '#print_instructions' do
      let(:expected_output) do
        get_expected_output(
          [
            "",
            "        Select search options:",
            "        * Press 1 to search Zendesk",
            "        * Press 2 to view a list of searchable fields",
            "        * Type 'quit' to exit",
            "",
          ]
        )
      end

      it 'prints the instructions' do
        expect { subject.print_instructions }.to output(expected_output).to_stdout
      end
    end

    describe '#search' do
      let(:field) { 'name' }

      let(:search_message) { "Searching treats for name with a value of liver strips\n" }

      let(:expected_output) do
        get_expected_output(
          [
            "",
            "--------------------",
            "id                              1",
            "name                            Liver Strips",
          ]
        )
      end

      before do
        allow(prompt).to receive(:select).with('Select:', anything).and_return(1)
        allow(prompt).to receive(:select).with('Select search term:', anything).and_return(field)
        allow(prompt).to receive(:ask).and_return('liver strips')
        subject.search
      end

      it 'prints "searching" message' do
        expect { subject.search }.to output(/#{search_message}/).to_stdout
      end

      it 'prints result' do
        expect { subject.search }.to output(/#{expected_output}/).to_stdout
      end

      describe 'when no results found' do
        let(:field) { 'weight' }

        it 'prints no results message' do
          expect { subject.search }.to output(/No results found/).to_stdout
        end
      end
    end

    describe '#print_searchable_fields' do
      let(:expected_output) do
        get_expected_output(
          [
            "",
            "--------------------",
            "Search Frens with",
            "id",
            "name",
            "type",
            "breed",
            "",
            "--------------------",
            "Search Treats with",
            "id",
            "name"
          ]
        )
      end

      it 'prints each collection and their searchable fields' do
        expect { subject.print_searchable_fields }.to output(expected_output).to_stdout
      end
    end

    describe '#main_menu' do
      before do
        allow(subject).to receive(:print_instructions)
        allow(prompt).to receive(:ask).and_return(option)
        allow(subject).to receive(:search)
        allow(subject).to receive(:print_searchable_fields)

        subject.main_menu
      end

      describe 'instructions' do
        let(:option) { 'na' }

        it 'invokes the instructions method' do
          expect(subject).to have_received(:print_instructions)
        end
      end

      describe 'when option selected is 1' do
        let(:option) { '1' }

        it 'runs search' do
          expect(subject).to have_received(:search)
        end
      end

      describe 'when option selected is 2' do
        let(:option) { '2' }

        it 'prints searchable fields' do
          expect(subject).to have_received(:print_searchable_fields)
        end
      end

      describe 'when input is an invalid argument' do
        let(:option) { 'nah' }

        it 'prints invalid argument message' do
          expect { subject.main_menu }.to output(/Your argument is invalid/).to_stdout
        end
      end
    end

    describe '#run' do
      before do
        allow(subject).to receive(:welcome_prompt)
        allow(subject).to receive(:print_instructions)
        allow(subject).to receive(:main_menu)
        allow(subject).to receive(:loop).and_yield.and_yield
        subject.run
      end

      it 'invokes the welcome message method' do
        expect(subject).to have_received(:welcome_prompt)
      end

      it 'loops main menu' do
        expect(subject).to have_received(:main_menu).twice
      end
    end
  end
end
