begin
  require_relative '../models/rental'
rescue LoadError => e
  if e.message =~ /rental/
    describe 'Rental' do
      it 'You need a `rental.rb` file for your `Rental` model' do
        fail
      end
    end
  else
    raise e
  end
end

require_relative '../data/database'

# test if class rental exist
describe Rental do
  file_path = File.expand_path('.') + '/data/input.json'
  database = Database.new(file_path)
  let(:cars) { database.cars }
  let(:rental) { Rental.new }

  it 'should return an instance of Rental when Rental.new is call' do
    expect(rental).to be_a Rental
  end

  it 'should be initialized with a hash of properties + list of cars' do
    properties = { id: 1, car_id: 1, start_date: "2015-12-8", end_date: "2015-12-8", distance: 100 }
    rental = Rental.new(properties, cars)
    expect(rental).to be_a Rental
  end

  describe '#id' do
    it 'should return the rental id' do
      rental = Rental.new({ id: 42 })
      expect(rental.id).to eq(42)
    end
  end

  describe '#id=' do
    it 'should set the rental id' do
      rental = Rental.new({ id: 42 })
      rental.id = 43
      expect(rental.id).to eq(43)
    end
  end

  describe '#start_date' do
    it 'should return the start_date of the rental' do
      rental = Rental.new({ start_date: '2017-12-8' })
      expect(rental.start_date).to eq('2017-12-8')
    end
  end

  describe '#end_date' do
    it 'should return the end_date of the rental' do
      rental = Rental.new({ end_date: '2017-12-10' })
      expect(rental.end_date).to eq('2017-12-10')
    end
  end

  describe '#distance' do
    it 'should return the distance of the rental' do
      rental = Rental.new({ distance: 100 })
      expect(rental.distance).to eq(100)
    end
  end

  describe '#car' do
    it 'should return the car of the rental' do
      properties = { id: 1, car_id: 1, start_date: '2017-12-8', end_date: '2017-12-10', distance: 100 }
      rental = Rental.new(properties, cars)
      expect(rental.car).to be_a Car
      expect(rental.car.id).to eq(1)
    end

    it 'should return nil if car of the rental not exist ' do
      properties = { id: 1, car_id: 2, start_date: '2017-12-8', end_date: '2017-12-10', distance: 100 }
      rental = Rental.new(properties, cars)
      expect(rental.car).to be_a NilClass
      expect(rental.car).to eq(nil)
    end
  end

  describe '#price' do
    it 'should return the price of a rental for One day' do
      properties = { id: 1, car_id: 1, start_date: '2015-12-8', end_date: '2015-12-8', distance: 100 }
      rental = Rental.new(properties, cars)
      expect(rental.price).to eq(3000)
    end

    it 'should return the price with a discount for Many days' do
      properties = { id: 2, car_id: 1, start_date: '2015-03-31', end_date: '2015-04-01', distance: 300 }
      rental = Rental.new(properties, cars)
      expect(rental.price).to eq(6800)
    end
  end

  describe '#extract_data' do
    it 'should return a hash with the id and the prie of the rental' do
      properties = { id: 3, car_id: 1, start_date: '2015-07-3', end_date: '2015-07-14', distance: 1000 }
      rental = Rental.new(properties, cars)
      expect(rental.extract_data).to be_a Hash
      expect(rental.extract_data).to eq(id: 3, price: 27800)
    end
  end
end
