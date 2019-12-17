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

# test if class actor exist
describe Actor do
  let(:actor) { Actor.new }

  it 'should return an instance of Actor when Actor.new is call' do
    expect(actor).to be_a Actor
  end

  it "should be initialized with a rental" do
    actor = Actor.new(rental)
    expect(actor).to be_a Actor
  end
end
