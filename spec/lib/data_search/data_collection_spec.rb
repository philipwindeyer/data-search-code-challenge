# frozen_string_literal: true

require 'data_search/data_collection'

module DataSearch
  RSpec.describe DataCollection do
    describe '#searchable' do
      describe 'with a single hash' do
        subject { DataCollection.new('Stickers', [{ name: 'CRA', iconDescription: 'Atom in a box', from: 'Create React App' }]).searchable }

        it 'returns an array of keys in single hash' do
          expect(subject).to eq([:name, :iconDescription, :from])
        end
      end

      describe 'with a single hash with a key containing an array' do
        subject { DataCollection.new('Stickers', [{ name: 'CRA', iconDescription: 'Atom in a box', from: 'Create React App', colors: ['light-blue', 'black'] }]).searchable }

        it 'returns an array of keys in single hash' do
          expect(subject).to eq([:name, :iconDescription, :from, :colors])
        end
      end

      describe 'with a hash with nested hash fields' do
        subject { DataCollection.new('Stickers', [{ name: 'CRA', iconDescription: 'Atom in a box', from: 'Create React App', dimensions: { x: 20, y: 8 } }]).searchable }

        it 'returns an array of keys in single hash' do
          expect(subject).to eq([:name, :iconDescription, :from, :dimensions, :x, :y])
        end
      end

      describe 'with an array of hashes' do
        let(:stickers) do
          [
            {
              name: 'CRA',
              iconDescription: 'Atom in a box',
              from: 'Create React App',
              dimensions: { x: 20, y: 8 }
            },
            {
              name: 'Octocat',
              iconDescription: 'Shady lookin octocat with a hat on and a cigar',
              from: 'Github',
              colors: ['grey']
            },
          ]
        end

        subject { DataCollection.new('Stickers', stickers).searchable }

        it 'returns an array of keys from each object in array' do
          expect(subject).to eq([:name, :iconDescription, :from, :dimensions, :x, :y, :colors])
        end
      end
    end

    describe '#valid_search_field?' do
      subject do
        DataCollection.new(
          'Stickers', [
            { name: 'CRA', iconDescription: 'Atom in a box', from: 'Create React App' }
          ]
        ).valid_search_field?(field)
      end

      describe 'when field is searchable' do
        let(:field) { 'iconDescription' }

        it 'is valid' do
          expect(subject).to eq(true)
        end
      end

      describe 'when field is not searchable' do
        let(:field) { 'notAValidFieldToSearchWith' }

        it 'is not valid' do
          expect(subject).to eq(false)
        end
      end
    end

    describe '#search' do
      let(:stickers) do
        [
          {
            name: 'CRA',
            iconDescription: 'Atom in a box',
            from: 'Create React App',
            dimensions: { x: 20, y: 8 },
            idealSurface: "Back of laptop"
          },
          {
            name: 'Octocat',
            iconDescription: 'Shady lookin octocat with a hat on and a cigar',
            from: 'Github',
            colors: ['grey'],
            dimensions: { x: 20, y: 8 },
            idealSurface: "Back of laptop"
          },
          {
            name: 'Apple Logo',
            iconDescription: 'Old school rainbow Apple logo',
            from: 'Apple',
            colors: ['green', 'yellow', 'orange', 'pink', 'purple', 'blue'],
            dimensions: { x: 15, y: 15 },
            idealSurface: "Side of tower"
          },
        ]
      end

      subject { DataCollection.new('Stickers', stickers).search(field, term) }

      describe 'when term has matching result' do
        describe 'and the search term corresponds to a top-level object' do
          let(:field) { 'name' }
          let(:term)  { 'CRA' }

          it 'returns the corresponding object' do
            expect(subject).to eq([{
                                    name: 'CRA',
                                    iconDescription: 'Atom in a box',
                                    from: 'Create React App',
                                    dimensions: { x: 20, y: 8 },
                                    idealSurface: "Back of laptop"
                                  }])
          end
        end

        describe 'and the search term is in a different case but has matching object' do
          let(:field) { 'name' }
          let(:term)  { 'cra' }

          it 'returns the corresponding object' do
            expect(subject).to eq([{
                                    name: 'CRA',
                                    iconDescription: 'Atom in a box',
                                    from: 'Create React App',
                                    dimensions: { x: 20, y: 8 },
                                    idealSurface: "Back of laptop"
                                  }])
          end
        end

        describe 'and the search term corresponds to multiple objects' do
          let(:field) { 'idealSurface' }
          let(:term)  { 'Back of laptop' }

          it 'returns the corresponding objects' do
            expect(subject).to eq([
                                    {
                                      name: 'CRA',
                                      iconDescription: 'Atom in a box',
                                      from: 'Create React App',
                                      dimensions: { x: 20, y: 8 },
                                      idealSurface: "Back of laptop"
                                    },
                                    {
                                      name: 'Octocat',
                                      iconDescription: 'Shady lookin octocat with a hat on and a cigar',
                                      from: 'Github',
                                      colors: ['grey'],
                                      dimensions: { x: 20, y: 8 },
                                      idealSurface: "Back of laptop"
                                    }
                                  ])
          end
        end

        describe 'and the value corresponds to a value in a string array' do
          let(:field) { 'colors' }
          let(:term)  { 'blue' }

          it 'returns the corresponding object' do
            expect(subject).to eq([{
                                    name: 'Apple Logo',
                                    iconDescription: 'Old school rainbow Apple logo',
                                    from: 'Apple',
                                    colors: ['green', 'yellow', 'orange', 'pink', 'purple', 'blue'],
                                    dimensions: { x: 15, y: 15 },
                                    idealSurface: "Side of tower"
                                  }])
          end
        end

        xdescribe 'and the search term corresponds a top-level key with a valid nested value' do
          let(:field) { 'dimensions' }
          let(:term)  { '20' }

          it 'returns the corresponding objects' do
            expect(subject).to eq([
                                    {
                                      name: 'CRA',
                                      iconDescription: 'Atom in a box',
                                      from: 'Create React App',
                                      dimensions: { x: 20, y: 8 },
                                      idealSurface: "Back of laptop"
                                    },
                                    {
                                      name: 'Octocat',
                                      iconDescription: 'Shady lookin octocat with a hat on and a cigar',
                                      from: 'Github',
                                      colors: ['grey'],
                                      dimensions: { x: 20, y: 8 },
                                      idealSurface: "Back of laptop"
                                    }
                                  ])
          end
        end

        xdescribe 'and the search term corresponds a nested term and value' do
          let(:field) { 'y' }
          let(:term)  { '8' }

          it 'returns the corresponding objects' do
            expect(subject).to eq([
                                    {
                                      name: 'CRA',
                                      iconDescription: 'Atom in a box',
                                      from: 'Create React App',
                                      dimensions: { x: 20, y: 8 },
                                      idealSurface: "Back of laptop"
                                    },
                                    {
                                      name: 'Octocat',
                                      iconDescription: 'Shady lookin octocat with a hat on and a cigar',
                                      from: 'Github',
                                      colors: ['grey'],
                                      dimensions: { x: 20, y: 8 },
                                      idealSurface: "Back of laptop"
                                    }
                                  ])
          end
        end

        # TODO describe 'and the objects have inconsistent definitions'
      end

      describe 'when there is no match found' do
        let(:field) { 'salutation' }
        let(:term)  { 'Jedi Master' }

        it 'returns an empty array' do
          expect(subject).to eq([])
        end
      end
    end
  end
end
