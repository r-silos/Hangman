class Game
    attr_reader :available_letters

    def initialize
        @lives = 7
        @guessboard = []
        @available_letters = alphabet_loop()
    end
    #function to print intro text
    def game_introduction
        puts "Welcome to Hangman! You will have seven lives to correctly guess the word chosen by the computer. If you fail, you will have blood on your hands (stick figure blood)"
        puts "You will be prompted each turn to guess a word. There will be a display showing  "
    end
    #loop to create an array containing all letters in apphabet(lowercase)
    def alphabet_loop
        alphabet_array = []
        for i in 97 .. 122
            alphabet_array.append(i.chr)
        end
        alphabet_array
    end
    #fucntion to reduece lives by 1 at end of each turn
    def lives_reducer
        @lives -= 1
    end
    #function to append guessed letter to guessboard 
    def letter_appender(letter)
        @guessboard.append(letter)
    end
    #function to delete guessed letter from @available_letters
    def letter_deletor(letter)
end

class Human

    #function to get input from user
    def input_getter
        print "\nHello HUMAN, type in your guess here: "
        guess = gets.chomp
    end


end

class Computer
    attr_accessor :secret_word

    #Loads in the dictionary file with each word as part of an array
    def initialize
        @contents = File.readlines('google-10000-english-no-swears.txt')
        @secret_word = secret_word_picker(@contents)

    end
    #Passes in contents of dictinary and keeps picking random word until 5-12 characters long   
    def secret_word_picker(dictionary)
        secret_word = ""
        until secret_word.length > 5 && secret_word.length < 15
            secret_word = dictionary[rand(1..9895)]
        end
        secret_word
    end 
end

al = Computer.new()
puts al.secret_word

#john = Game.new()
#print john.available_letters.flatten