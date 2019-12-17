# frozen_string_literal: true

# Class Actor generate the model actor
# give how much money must be debited/credited for each actor
class Actor
  attr_reader :actions
  ACTORS =
    {
      driver: 'debit',
      owner: 'credit',
      insurance: 'credit',
      assistance: 'credit',
      drivy: 'credit'
    }.freeze

  def initialize(rental)
    @rental = rental
    @actions = []
    actions_with_actor
  end

  private

  def actions_with_actor
    ACTORS.each do |actor, debit_or_credit|
      @actions << { who: actor.to_s,
                    type: debit_or_credit,
                    amount: __send__(actor) }
    end
  end

  def driver
    @rental.price
  end

  def owner
    @rental.price - @rental.commission
  end

  def insurance
    @rental.insurance_fee
  end

  def assistance
    @rental.assistance_fee
  end

  def drivy
    @rental.drivy_fee
  end
end
