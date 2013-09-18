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
#sources: https://gist.github.com/tomtung/1973534

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

module Enumerable
	def palindrome?
		array = {} #=> make empty array
		self.collect{|num| num} == self.collect{|num|num}.reverse #=> compare array of numbers to its reversed self
	end
end

#=> Part 4: Blocks

	#sources:#sources: https://github.com/kevdashdev/saas-hw1/blob/master/ruby/part7.rb 

class CartesianProduct
	include Enumerable

		def initialize(sequence1, sequence2)
			@sequence1 = sequence1
			@sequence2 = sequence2
		end

		def each
			unless @sequence1.empty? && @sequence2.empty? #=>don't execute if the sequences are empty
			combination_sequence = []
			@sequence1.each do |s1|
				combination_sequence << @sequence2.each {|s2| yield [s1] << s2} #=>iterate through the first sequence while putting the second sequence in an array with the first		
			end
		end
	end
end
