require_relative "people"

class Voter < People
	attr_accessor :name, :politics
	def initialize(name, politics)
		super(name)
		@politics = politics
	end
end
