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
		return false
	end
	
	def delicious?
		return true
	end
end

class JellyBean < Dessert	
	def initlize(name, calories, flavor)
		@flavor = flavor
	end
	
	def delicious?
		if @flavor == "black licorice"
			return false
		end
		return true
	end
end

#=> Part 2: Object Oriented Programming

class Class
	def attr_accessor_with_history(attr_name)
		attr_name = attr_name.to_s
		attr_reader attr_name
		attr_reader attr_name+"_history"
		class_eval "   "
	end
end

class Foo
	attr_accessor_with_history :bar
end
