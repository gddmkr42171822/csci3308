# Part1: Hello World
class HelloWorldClass
	def initialize(name)
		@name = name.capitalize
	end
	def sayHi
		puts "Hello #{@name}!"
	end
end
hello = HelloWorldClass.new("Bob")
hello.sayHi


# Part2: Strings
def palindrome?(string)
	temp_str = string.downcase.gsub(/\W/, "")
	temp_str == temp_str.reverse 
end

#=> palindrom test: puts palindrome?("Madam, I'm Adam!")


def count_words(string)
	
end
