begin
  require_relative '../models/car'
rescue LoadError => e
  if e.message =~ /car/
    describe 'Car' do
      it 'You need a `car.rb` file for your `Car` model' do
        fail
      end
    end
  else
    raise e
  end
end

# test if class car exist
describe Car do
  let(:car) { Car.new }

  it 'should return an instance of Car when Car.new is call' do
    expect(car).to be_a Car
  end

  it "should be initialized with a hash of properties" do
    properties = { "id": 1, "price_per_day": 2000, "price_per_km": 10 }
    car = Car.new(properties)
    expect(car).to be_a Car
  end

  describe "#id" do
    it "should return the car id" do
      car = Car.new({ id: 42 })
      expect(car.id).to eq(42)
    end
  end

  describe "#id=" do
    it "should set the car id" do
      car = Car.new({ id: 42 })
      car.id = 43
      expect(car.id).to eq(43)
    end
  end

  describe "#price_per_day" do
    it "should return the price_per_day of the car" do
      car = Car.new({ price_per_day: 2000 })
      expect(car.price_per_day).to eq(2000)
    end
  end

  describe "#price_per_km" do
    it "should return the price_per_km of the car" do
      car = Car.new({ price_per_km: 8 })
      expect(car.price_per_km).to eq(8)
    end
  end
end
