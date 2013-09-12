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

# Part3: Rock Paper Scissors
class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
	raise WrongNumberOfPlayersError unless game.length == 2
	p1strategy = game[0][1].downcase
	p2strategy = game[1][1].downcase
	raise NoSuchStrategyError unless p1strategy == "r" || p1strategy == "p" || p1strategy == "s"
	raise NoSuchStrategyError unless p2strategy == "r" || p2strategy == "p" || p2strategy == "s"
	
	if p1strategy == "p" and p2strategy == "s"
		return game[1]
	elsif p1strategy == "p" and p2strategy == "r"
		return game[0]
	elsif p1strategy == "p" and p2strategy == "p"
		return "Tie"
	elsif p1strategy == "r" and p2strategy == "p"
		return game[1]
	elsif p1strategy == "r" and p2strategy == "s"
		return game[0]
	elsif p1strategy == "r" and p2strategy == "r"
		return "Tie"
	elsif p1strategy == "s" and p2strategy == "p"
		return game[0]
	elsif p1strategy == "s" and p2strategy == "r"
		return game[1]
	elsif p1strategy == "s" and p2strategy == "s"
		return "Tie"
	#sources: http://codepad.org/Xbdvs7CQ
end

puts rps_game_winner([["Armando", "P"], ["Dave", "S"]])


# Part4: Anagram
def combine_anagrams(words)
	words.group_by { |word| word.each_char.sort }.values #=>make a hash with each word as a key and an array of words related to each key as the values
	#source: http://stackoverflow.com/questions/16631961/how-can-i-simplify-or-clean-up-this-anagram-method
end

#=> combine_anagrams test: puts combine_anagrams(['cars', 'for', 'creams', 'fuck', 'racs', 'four', 'scar', 'potatoes','uckf', 'scream'])
