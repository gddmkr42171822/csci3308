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
	temp_str = string.downcase #=> get rid of non-words
	wordarray = temp_str.scan(/\w+/) #=> put words from string into array
	myhash = Hash.new(0) #=> new hash
	wordarray.each {|word| myhash[word] += 1 } #=> puts elements of array into hash as keys and keeps track of how many times the word appears
	return myhash
end

#=> count_words test: puts count_words("A man, a plan, a canal -- Panama")
#=> puts count_words("Doo bee doo bee doo")

# Part4: Anagram
def combine_anagrams(words)

end
