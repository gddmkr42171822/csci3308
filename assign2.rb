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

#sources:https://github.com/kevdashdev/saas-hw1/blob/master/ruby/part5.rb
#sources:http://stackoverflow.com/questions/9561072/ruby-using-class-eval-to-define-methods

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

#sources: http://stackoverflow.com/questions/9651612/ruby-method-missing
#sources: https://github.com/kevdashdev/saas-hw1/blob/master/ruby/part6.rb

class Numeric
	@@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' =>1}
	def method_missing(method_id)
		singular_currency = method_id.to_s.gsub( /s$/, '') #=> gets rid of spaces and converts thing to string
		if @@currencies.has_key?(singular_currency)
			self * @@currencies[singular_currency]
		else
			super
		end
	end

	def in(currency) #=> method takes in currency
		singular_currency = currency.to_s.gsub( /s$/, '') #=> converts it to string
		self / @@currencies[singular_currency] #=> goes into class variable, finds value from key
	end
end

class String
	def palindrome?
		temp_str = self.downcase.gsub(/\W/, "")
		temp_str == temp_str.reverse 
	end
end
