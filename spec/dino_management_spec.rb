# frozen_string_literal: true

require 'pry'

RSpec.describe DinoManagement do
  it 'has a version number' do
    expect(DinoManagement::VERSION).not_to be_nil
  end

  describe 'Dino Management' do
    let(:old_herbivore) do
      { 'name' => 'DinoA', 'category' => 'herbivore', 'period' => 'Cretaceous', 'diet' => 'plants', 'age' => 100 }
    end
    let(:healthy_carnivore) do
      { 'name' => 'DinoB', 'category' => 'carnivore', 'period' => 'Jurassic', 'diet' => 'meat', 'age' => 80 }
    end

    let(:dino_data) { [old_herbivore, healthy_carnivore] }

    context 'when using the long and unoptimized method' do
      describe 'with an empty dino list' do
        let(:dino_data) { [] }

        xit 'returns an empty list' do
          expect(described_class.run(dino_data)).to eq({ dinos: [], summary: {} })
        end

        xit 'returns an empty summary' do
          expect(described_class.run(dino_data)[:summary]).to eq({})
        end
      end

      describe 'dino health calculation' do
        subject(:result) { described_class.run(dino_data) }

        it 'calculates herbivore dino health correctly' do
          expect(result[:dinos][0]['health']).to eq(0)
        end

        it 'calculates carnivore dino health correctly' do
          expect(result[:dinos][1]['health']).to eq(100 - healthy_carnivore['age'])
        end

        context 'with zero age' do
          let(:zero_age_dino) { [{ 'name' => 'DinoC', 'category' => 'herbivore', 'period' => 'Jurassic', 'diet' => 'plants', 'age' => 0 }] }
          
          it 'sets health to zero' do
            result = described_class.run(zero_age_dino)
            expect(result[:dinos][0]['health']).to eq(0)
          end
        end
      end

      describe 'dino comment setting' do
        subject(:result) { described_class.run(dino_data) }

        it 'assigns dino as Dead when health is 0' do
          expect(result[:dinos][0]['comment']).to eq('Dead')
        end

        it 'assigns dino as Alive when health is above zero' do
          expect(result[:dinos][1]['comment']).to eq('Alive')
        end
      end

      describe 'dino age metric calculation' do
        subject(:result) { described_class.run(dino_data) }

        it 'sets age_metrics to 0 for dead dinos' do
          expect(result[:dinos][0]['age_metrics']).to eq(0)
        end

        it 'sets age_metrics to half the age for alive dinos' do
          expect(result[:dinos][1]['age_metrics']).to eq(healthy_carnivore['age'] / 2)
        end
      end

      describe 'dino category summary' do
        subject(:result) { described_class.run(dino_data) }

        it 'counts herbivore dinos correctly' do
          expect(result[:summary]['herbivore']).to eq(1)
        end

        it 'counts carnivore dinos correctly' do
          expect(result[:summary]['carnivore']).to eq(1)
        end
      end
    end
  end
end
