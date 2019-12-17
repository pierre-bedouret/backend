# frozen_string_literal: true

# Class Option generate the model option
# with e.g : { "id": 1, "rental_id": 1, "type": "gps" }
class Option
  attr_accessor :id, :rental, :type

  def initialize(attributes = {})
    @id = attributes[:id]
    @rental = attributes[:rental_id]
    @type = attributes[:type]
  end
end
