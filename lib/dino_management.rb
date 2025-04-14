# frozen_string_literal: true

require_relative 'dino_management/version'

module DinoManagement
  class Error < StandardError; end

  def self.run(dinos)
    return { dinos: [], summary: {} } if dinos.empty? || dinos.nil?
    dinos.each do |dino|
      if dino['age'] > 0
        if dino['category'] == 'herbivore'
          dino['health'] = dino['diet'] == 'plants' ? (100 - dino['age']) : (100 - dino['age']) / 2
        elsif dino['category'] == 'carnivore'
          dino['health'] = dino['diet'] == 'meat' ? (100 - dino['age']) : (100 - dino['age']) / 2
        end
      else
        dino['health'] = 0
      end

      if dino['health'] > 0
        dino['comment'] = 'Alive'
      else
        dino['comment'] = 'Dead'
      end
    end

    dinos.each do |dino|
      if dino['comment'] == 'Alive'
        if dino['age'] > 1
          dino['age_metrics'] = (dino['age'] / 2).to_i
        else
          dino['age_metrics'] = 0
        end
      else
        dino['age_metrics'] = 0
      end
    end

    if dinos && dinos.length > 0
      categories = dinos.group_by { |dino| dino['category'] }.map do |category, dino_list|
        { category: category, count: dino_list.count }
      end
    end

    summary = {}
    categories.each do |category_metrics|
      summary[category_metrics[:category]] = category_metrics[:count]
    end

    { dinos: dinos, summary: summary }
  end
end
