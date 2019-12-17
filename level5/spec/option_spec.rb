begin
  require_relative '../models/option'
rescue LoadError => e
  if e.message =~ /option/
    describe 'Option' do
      it 'You need a `option.rb` file for your `Option` model' do
        fail
      end
    end
  else
    raise e
  end
end

# test if class option exist
describe Option do
  let(:option) { Option.new }

  it 'should return an instance of Option when Option.new is call' do
    expect(option).to be_a Option
  end

  it 'should be initialized with a hash of properties' do
    properties = { id: 1, rental_id: 2, type: 'additional_insurance' }
    option = Option.new(properties)
    expect(option).to be_a Option
  end

  describe '#id' do
    it 'should return the option id' do
      option = Option.new(id: 42)
      expect(option.id).to eq(42)
    end
  end

  describe '#id=' do
    it 'should set the option id' do
      option = Option.new(id: 42)
      option.id = 43
      expect(option.id).to eq(43)
    end
  end

  describe '#rental' do
    it 'should return the rental_id of the option' do
      option = Option.new(rental_id: 2)
      expect(option.rental).to eq(2)
    end
  end

  describe '#type' do
    it 'should return the type of the option' do
      option = Option.new(type: 'gps')
      expect(option.type).to eq('gps')
    end
  end
end
