# frozen_string_literal: true

require 'date'

# Class Rental generate the model rental
# with e.g : { "id": 1, "car_id": 1, "start_date": "2017-12-8", "end_date": "2017-12-10", "distance": 100 },
class Rental
  attr_accessor :id
  attr_reader :car, :start_date, :end_date, :distance

  def initialize(attributes = {}, cars = [])
    @id = attributes[:id]
    @car = cars.find { |car| car.id == attributes[:car_id] }
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
    @distance = attributes[:distance]
  end

  def price
    duration * @car.price_per_day + @distance * @car.price_per_km
  end

  def extract_data
    { id: @id, price: price }
  end

  private

  def duration
    (Date.parse(@end_date) - Date.parse(@start_date)).to_i + 1
  end
end
