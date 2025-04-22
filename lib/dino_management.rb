# frozen_string_literal: true

require_relative 'dino_management/version'

# Dino Management
module DinoManagement
  class Error < StandardError; end

  def self.run(dinos)
    return { 'dinos' => [], 'summary' => {} } if dinos.empty? || dinos.nil?

    dinos.each do |dino|
      dino['health'] = calculate_health(dino)
      dino['comment'] = determine_status(dino['health'])
      dino['age_metrics'] = calculate_age_metrics(dino)
    end

    categories = category_summary(dinos) if dinos&.length&.positive?

    {
      'dinos' => dinos,
      'summary' => format_summary(categories)
    }
  end

  def self.calculate_health(dino)
    return 0 unless dino['age'].nil? || dino['age'].positive?

    return (100 - dino['age']) / 2 if dino['category'] == 'herbivore'

    (100 - dino['age']) if dino['category'] == 'carnivore'
  end

  def self.determine_status(health)
    health.positive? ? 'Alive' : 'Dead'
  end

  def self.calculate_age_metrics(dino)
    dino['age'] = dino['age'].to_i if dino['age'].is_a?(String)

    return (dino['age'] / 2).to_i if dino['comment'] == 'Alive' && dino['age'] > 1

    0
  end

  def self.category_summary(dinos)
    dinos.group_by { |dino| dino['category'] }.map do |category, dino_list|
      { category: category, count: dino_list.count }
    end
  end

  def self.format_summary(categories)
    summary = {}
    categories.each do |category_metrics|
      summary[category_metrics[:category]] = category_metrics[:count]
    end
    summary
  end
end
