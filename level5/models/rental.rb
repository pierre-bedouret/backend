# frozen_string_literal: true

require 'date'
require_relative 'actor'

# Class Rental generate the model rental
# with e.g : { "id": 1,"car_id": 1, "start_date": "2017-12-8", "end_date": "2017-12-10", "distance": 100 },
class Rental
  attr_accessor :id
  attr_reader :car, :start_date, :end_date, :distance
  # Fee
  TOTAL_COMMISSION = 0.3
  INSURANCE_PART = 0.5
  ASSISTANCE_FEE_PER_DAY = 100
  # Options
  GPS_FEE_PER_DAY = 500
  BABY_SEAT_FEE_PER_DAY = 200
  ADD_INSURANCE_PER_DAY = 1000

  def initialize(attributes = {}, cars = [], options = [])
    @id = attributes[:id]
    @car = cars.find { |car| car.id == attributes[:car_id] }
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
    @distance = attributes[:distance]
    @options = options.select { |option| option.rental == @id }
  end

  def price
    price_per_day_with_discount(duration) + @distance * @car.price_per_km
  end

  def extract_data
    { id: @id, price: price, commission: commission_compilation }
  end

  def extract_data_with_actor_and_options
    @actor = Actor.new(self)
    options = @options.map(&:type)

    { id: @id, options: options, actions: @actor.actions }
  end

  def commission
    (price * TOTAL_COMMISSION).to_i
  end

  def insurance_fee
    (commission * INSURANCE_PART).to_i
  end

  def assistance_fee
    (duration * ASSISTANCE_FEE_PER_DAY).to_i
  end

  def drivy_fee
    (commission - insurance_fee - assistance_fee).to_i
  end

  def options_price
    owner_options + drivy_options
  end

  def owner_options
    owner_options = 0

    @options.each do |option|
      case option.type
      when 'gps' then owner_options += GPS_FEE_PER_DAY
      when 'baby_seat' then owner_options += BABY_SEAT_FEE_PER_DAY
      end
    end

    owner_options * duration
  end

  def drivy_options
    drivy_options = 0

    @options.each do |option|
      case option.type
      when 'additional_insurance' then drivy_options += ADD_INSURANCE_PER_DAY
      end
    end

    drivy_options * duration
  end

  private

  def duration
    (Date.parse(@end_date) - Date.parse(@start_date)).to_i + 1
  end

  def price_per_day_with_discount(duration)
    total_price_per_day = 0

    duration.times do |d|
      if d == 0
        total_price_per_day += @car.price_per_day
      elsif d >= 1 && d < 4
        total_price_per_day += (@car.price_per_day * 0.9)
      elsif d >= 4 && d < 10
        total_price_per_day += (@car.price_per_day * 0.7)
      else
        total_price_per_day += (@car.price_per_day * 0.5)
      end
    end

    total_price_per_day.to_i
  end

  def commission_compilation
    {
      insurance_fee: insurance_fee,
      assistance_fee: assistance_fee,
      drivy_fee: drivy_fee
    }
  end
end
