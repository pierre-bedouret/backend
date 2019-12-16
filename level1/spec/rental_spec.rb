

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

# test if class rental exist
describe Rental do
  # let(:cars) { INPUT[:cars] }
  let(:rental) { Rental.new }

  it 'should return an instance of Rental when Rental.new is call' do
    expect(rental).to be_a Rental
  end

  it "should be initialized with a hash of properties + list of cars" do
    properties = { "id": 1, "price_per_day": 2000, "price_per_km": 10 }
    rental = Rental.new(properties)
    expect(rental).to be_a Rental
  end

  describe "#id" do
    it "should return the rental id" do
      rental = Rental.new({ id: 42 })
      expect(rental.id).to eq(42)
    end
  end

  describe "#id=" do
    it "should set the rental id" do
      rental = Rental.new({ id: 42 })
      rental.id = 43
      expect(rental.id).to eq(43)
    end
  end

  describe "#start_date" do
    it "should return the start_date of the rental" do
      rental = Rental.new({ start_date: "2017-12-8" })
      expect(rental.start_date).to eq("2017-12-8")
    end
  end

  describe "#end_date" do
    it "should return the end_date of the rental" do
      rental = Rental.new({ end_date: "2017-12-10" })
      expect(rental.end_date).to eq("2017-12-10")
    end
  end

  describe "#distance" do
    it "should return the distance of the rental" do
      rental = Rental.new({ distance: 100 })
      expect(rental.distance).to eq(100)
    end
  end

  # describe "#car" do
  #   it "should return the car of the rental" do
  #     rental = Rental.new({ car_id: 1 })
  #     expect(rental.car).to be_a Car
  #   end
  # end
end
