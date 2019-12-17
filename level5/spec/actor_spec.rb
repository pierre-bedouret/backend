begin
  require_relative '../models/actor'
rescue LoadError => e
  if e.message =~ /actor/
    describe 'Actor' do
      it 'You need a `actor.rb` file for your `Actor` model' do
        fail
      end
    end
  else
    raise e
  end
end

require_relative '../data/database'

# test if class actor exist
describe Actor do
  file_path = File.expand_path('.') + '/data/input.json'
  database = Database.new(file_path)
  let(:rentals) { database.rentals }
  let(:rental) { rentals.first }
  let(:actor) { Actor.new(rental) }

  it 'should return an instance of Actor when Actor.new(rental) is call' do
    expect(actor).to be_a Actor
  end

  it "should be initialized with a rental" do
    actor = Actor.new(rental)
    expect(actor).to be_a Actor
  end

  describe '#actions' do
    it 'should return an array' do
      expect(actor.actions).to be_a Array
    end

    it 'should return an array of hash for a given rental' do
      expect(actor.actions).to eq(
        [
          {
            who: 'driver',
            type: 'debit',
            amount: 3000
          },
          {
            who: 'owner',
            type: 'credit',
            amount: 2100
          },
          {
            who: 'insurance',
            type: 'credit',
            amount: 450
          },
          {
            who: 'assistance',
            type: 'credit',
            amount: 100
          },
          {
            who: 'drivy',
            type: 'credit',
            amount: 350
          }
        ]
      )
    end
  end
end
