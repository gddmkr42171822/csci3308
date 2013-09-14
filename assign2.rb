# Robert Werthman
# Assignment 2


#=> Part 1: Classes
class Dessert
	def initialize(name, calories)
		@name = name
		@calories = calories
	end
	
	def healthy?
		if @calories < 200
			return true
		end
	end
	
	def delicious?
		return true
	end
end

class JellyBean < Dessert	
	def initlize(name, calories, flavor)
	
	end
	
	def delicious?
	
	end
end
