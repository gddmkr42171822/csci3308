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
		class_eval %Q"
            def #{attr_name}=(value)
                if !defined? @#{attr_name}_history
                    @#{attr_name}_history = [@#{attr_name}]
                end
                @#{attr_name} = value
                @#{attr_name}_history << value
            end
        "
	end
end

class Foo
	attr_accessor_with_history :bar
end

#=> Part 3: More OOP

class Numeric
	@@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
	def method_missing(method_id)
		singular_curreny = method_id.to_s.gsub( /s$/, '')
		if @@currencies.has_key?(singular_currency)
			self * @@currencies[singular_currency]
		else
			super
		end
	end
end
