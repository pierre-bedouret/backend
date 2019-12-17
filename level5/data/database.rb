# frozen_string_literal: true

require 'json'
require_relative '../models/car'
require_relative '../models/rental'
require_relative '../models/option'

# Class Database generate the data from the json
# cars = [{ "id": 1, "price_per_day": 2000, "price_per_km": 10 }]
# rentals = [{ "id": 1, "car_id": 1, "start_date": "2017-12-8", "end_date": "2017-12-10", "distance": 100 }]
class Database
  attr_accessor :cars, :rentals, :options

  def initialize(file_path)
    @cars = []
    @rentals = []
    @options = []
    @file = file_path
    load_data_from_json if File.exist? file_path
  end

  private

  def load_data_from_json
    serialized_input = File.read(@file)
    input = JSON.parse(serialized_input, symbolize_names: true)

    @cars = input[:cars].map { |car_attr| Car.new(car_attr) }

    @options = input[:options].map { |option_attr| Option.new(option_attr) }

    @rentals = input[:rentals].map do |rental_attr|
      Rental.new(rental_attr, @cars, @options)
    end
  end
end

# file_path = File.expand_path File.dirname(__FILE__) + '/input.json'
# database = Database.new(file_path)

# p database.rentals
# p database.cars
# p database.options
