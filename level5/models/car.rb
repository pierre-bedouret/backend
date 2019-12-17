# frozen_string_literal: true

# Class car generate the model car
# with e.g : { "id": 1, "price_per_day": 2000, "price_per_km": 10 }
class Car
  attr_accessor :id, :price_per_day, :price_per_km

  def initialize(attributes = {})
    @id = attributes[:id]
    @price_per_day = attributes[:price_per_day]
    @price_per_km = attributes[:price_per_km]
  end
end
