# frozen_string_literal: true

# This is a poorly written code for the management of dinos.
# The purpose of this code is to serve as a refactor test for
# candidates applying for a software engineer position at our company.
# We expect you to refactor it and turn it into an efficient
# and maintainable code, following best practices. Fill in the Rspect test as well, modify it to your liking,
# we do want to see some decent testing.
# Please don't spend too much time on this, we know your time is valuable and we want to
# make this fun but also allow you to show off your ruby skills :)
#
# Existing data: [
#   { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
#   { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
# ]
#

require_relative 'dino_management/version'

module DinoManagement
  class Error < StandardError; end

  def self.run(dinos)
    dinos.each do |d|
      age = if d['age'].is_a?(Integer)
              d['age']
            else
              d['age'].to_i
            end

      if age.positive?
        if d['category'] == 'herbivore'
          d['health'] = d['diet'] == 'plants' ? (100 - age) : (100 - age) / 2
        elsif d['category'] == 'carnivore'
          d['health'] = d['diet'] == 'meat' ? (100 - age) : (100 - age) / 2
        end
      else
        d['health'] = 0
      end

      d['comment'] = if d['health'].positive?
                       'Alive'
                     else
                       'Dead'
                     end

      d['age_metrics'] = if d['comment'] == 'Alive'
                           if age > 1
                             (age / 2).to_i
                           else
                             0
                           end
                         else
                           0
                         end
    end

    if dinos&.length&.positive?
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
