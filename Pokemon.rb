# holds information about our pokemon 
class Poke
	# create our class variables 
	def initialize
		@name = ""
		@num = ""
		@type1 = ""
		@type2 = ""
		@attack = 0
		@hp = 1
		@maxHp = 0
		@move1 = Move.new
		@move2 = Move.new
		@move3 = Move.new
		@move4 = Move.new
	end
	# set the class variables
	def setter(name, num, type1, type2, hp, attack)
		@name = name
		@num = num
		@type1 = type1
		@type2 = type2
		@hp = hp.to_i
		@attack = attack.to_i
		@maxHp = hp.to_i
	end
	# decrement health by 1 hp
	def decre
		@hp = @hp - 1
	end
end
# holds information about our moves 
class Move
	# create class variables 
	def initilize
		@name = "Tackle"
		@type = "Normal"
		@damage = 8
	end
	# set the class variables 
	def setter(name, type, damage)
		@name = name
		@type = type
		@damage = damage.to_i
	end
end 