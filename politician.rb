require_relative "people"

class Pol < People
  attr_accessor :name, :party
  def initialize(name, party)
    super(name)
    @party = party
  end
end
