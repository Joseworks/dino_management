# frozen_string_literal: true

require_relative 'dino_management/version'

module DinoManagement
  class Error < StandardError; end

  def self.run(dinos)
    return { dinos: [], summary: {} } if dinos.empty? || dinos.nil?
    dinos.each do |d|
      if d['age'] > 0
        if d['category'] == 'herbivore'
          d['health'] = d['diet'] == 'plants' ? (100 - d['age']) : (100 - d['age']) / 2
        else
          if d['category'] == 'carnivore'
            d['health'] = d['diet'] == 'meat' ? (100 - d['age']) : (100 - d['age']) / 2
          end
        end
      else
        d['health'] = 0
      end

      if d['health'] > 0
        d['comment'] = 'Alive'
      else
        d['comment'] = 'Dead'
      end
    end

    dinos.each do |d|
      if d['comment'] == 'Alive'
        if d['age'] > 1
          d['age_metrics'] = (d['age'] / 2).to_i
        else
          d['age_metrics'] = 0
        end
      else
        d['age_metrics'] = 0
      end
    end

    if dinos && dinos.length > 0
      a = dinos.group_by { |d| d['category'] }.map do |category, dino_list|
        { category: category, count: dino_list.count }
      end
    end

    f = {}
    a.each do |category_metrics|
      f[category_metrics[:category]] = category_metrics[:count]
    end

    { dinos: dinos, summary: f }
  end
end
