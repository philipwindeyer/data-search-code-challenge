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
  end
end
