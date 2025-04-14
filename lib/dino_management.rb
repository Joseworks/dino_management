# frozen_string_literal: true

require_relative 'dino_management/version'

module DinoManagement
  class Error < StandardError; end

  def self.run(dinos)
    return { dinos: [], summary: {} } if dinos.empty? || dinos.nil?

    dinos.each do |dino|
      if dino['age'].positive?
        if dino['category'] == 'herbivore'
          dino['health'] = dino['diet'] == 'plants' ? (100 - dino['age']) : (100 - dino['age']) / 2
        elsif dino['category'] == 'carnivore'
          dino['health'] = dino['diet'] == 'meat' ? (100 - dino['age']) : (100 - dino['age']) / 2
        end
      else
        dino['health'] = 0
      end

      dino['comment'] = if dino['health'].positive?
                          'Alive'
                        else
                          'Dead'
                        end

      dino['age_metrics'] = calculate_age_metrics(dino)
    end

    categories = category_summary(dinos) if dinos&.length&.positive?

    summary = {}
    categories.each do |category_metrics|
      summary[category_metrics[:category]] = category_metrics[:count]
    end

    { dinos: dinos, summary: summary }
  end

  def self.calculate_age_metrics(dino)
    return (dino['age'] / 2).to_i if dino['comment'] == 'Alive' && dino['age'] > 1

    0
  end

  def self.category_summary(dinos)
    dinos.group_by { |dino| dino['category'] }.map do |category, dino_list|
      { category: category, count: dino_list.count }
    end
  end
end
