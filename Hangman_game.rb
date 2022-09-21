class Game
    attr_reader :available_letters, :guessboard

    def initialize
        @lives = 7
        @guessboard = []
        @available_letters = alphabet_loop()
        @secret_word = ''
    end
    
    #function to print intro text
    def game_introduction
        puts "Welcome to Hangman! You will have seven lives to correctly guess the word chosen by the computer. If you fail, you will have blood on your hands (stick figure blood)"
        puts "You will be prompted each turn to guess a letter. There will be a display showing  "
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
        @available_letters.delete(letter)
    end

    #fucntion to set secret word
    def secret_word_setter(secret_code)
        @secret_word = secret_code.split(//)
    end

    #function to create array to hold correct number of letter of secret word
    def correct_guess_array_creator(sc)
        @correct_guess_array = Array.new(sc.length - 1)
    end

    #compound function to hold functions related to secrert word
    def secret_code_setter_and_array_creator(code)
        secret_word_setter(code)
        correct_guess_array_creator(code)
    end


    def letter_checker(letter)
    
    end
=begin
    def display
        puts "Guessboard:               Availabe_letters:"
        i = 0
        while i < 
=end
end

class Human

    #function to get input from user
    def input_getter
        print "\nHello HUMAN, type in your letter guess here: "
        guess = gets.chomp.downcase
    end

    #function to ensure user's input is valid and in array of options
    def input_verifier(input,alpha_array)
        until alpha_array.include?(input)
            puts "\nHey Bucko, that input is not valid, please select a letter you have not chosen"
            print "Please input a valid letter here: "
            input = gets.chomp
        end
        input
    end

    #compund function that gets input and verifies it
    def all_input(alpha_array)
        letter = input_getter()
        letter = input_verifier(letter,alpha_array)
        letter
    end



end

class Computer
    attr_reader :secret_word

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


juego = Game.new()
john = Human.new()
al = Computer.new()

juego.secret_code_setter_and_array_creator(al.secret_word)

5.times do
    let = john.all_input(juego.available_letters)
    juego.letter_deletor(let)
    juego.letter_appender(let)
end

print juego.available_letters
puts
print juego.guessboard