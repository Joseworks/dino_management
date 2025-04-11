# frozen_string_literal: true

require 'pry'

RSpec.describe DinoManagement do
  it 'has a version number' do
    expect(DinoManagement::VERSION).not_to be_nil
  end

  describe 'Dino Management' do
    let(:dino_data) do
      [
        { 'name' => 'DinoA', 'category' => 'herbivore', 'period' => 'Cretaceous', 'diet' => 'plants', 'age' => 100 },
        { 'name' => 'DinoB', 'category' => 'carnivore', 'period' => 'Jurassic', 'diet' => 'meat', 'age' => 80 }
      ]
    end

    context 'when using the long and unoptimized method' do
      describe 'dino health calculation' do
        subject(:result) { described_class.run(dino_data) }

        it 'calculates herbivore dino health correctly' do
          expect(result[:dinos][0]['health']).to eq(0)
        end

        it 'calculates carnivore dino health correctly' do
          expect(result[:dinos][1]['health']).to eq(20)
        end
      end

      describe 'dino comment setting' do
        it 'assigns appropriate comment based on health' do
          # Fill in expectations here
        end
      end

      describe 'dino age metric calculation' do
        it 'computes age_metrics based on age and comment' do
          # Fill in expectations here
        end
      end

      describe 'dino category summary' do
        it 'counts dinos by categories' do
          # Fill in expectations here
        end
      end
    end
  end
end
