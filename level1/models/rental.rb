# frozen_string_literal: true

# Class Rental generate the model rental
# with e.g : { "id": 1, "car_id": 1, "start_date": "2017-12-8", "end_date": "2017-12-10", "distance": 100 },
class Rental
  attr_accessor :id
  attr_reader :start_date, :end_date, :distance

  def initialize(attributes = {})
    @id = attributes[:id]
    @car_id = attributes[:car_id]
    # @car = cars.find { |car| car.id == @car_id } || []
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
    @distance = attributes[:distance]
  end
end
