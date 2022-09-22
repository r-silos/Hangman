class Game
    attr_reader :available_letters, :guessboard, :correct_guess_array, :game_over, :secret_word

    def initialize
        @lives = 7
        @guessboard = []
        @available_letters = alphabet_loop()
        @secret_word = ''
        @game_over = false
        @game_won = false
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
    
    #fucntion to reduece lives by 1 at end of each turn and check if out of lives
    def lives_reducer_and_checker
        @lives -= 1
        if @lives == 0
            @game_over = true
        end
    end

    #function to check if game was won
    def game_won?
        puts "The guessboard is #{@guessboard}"
        puts "the secret word is #{@secret_word}"
        
        if @guessboard == @secret_word
            @game_over = true
            @game_won = true
            puts "game has been won"
        end
    end
    
    #function to append guessed letter to guessboard 
    def letter_appender(letter)
        @guessboard.append(letter)
    end
    
    #function to delete guessed letter from @available_letters
    def letter_deletor(letter)
        @available_letters.delete(letter)
    end

    #compound function to append letter to guessboard and deleter letter from available lettor
    def letter_deletor_and_appendor(letter)
        letter_appender(letter)
        letter_deletor(letter)
    end

    #fucntion to set secret word
    def secret_word_setter(secret_code)
        @secret_word = secret_code.chomp.split(//)
    end

    #function to create array to hold correct number of letter of secret word
    def correct_guess_array_creator(sc)
        @correct_guess_array = Array.new(sc.length - 1, '_')
    end

    #compound function to hold functions related to secrert word
    def secret_code_setter_and_array_creator(code)
        secret_word_setter(code)
        correct_guess_array_creator(code)
    end

    #function to find whether letter is in secret word and return an array with indexes of where letter was found
    def letter_checker(letter)
        correct_indexes_array = []
        @secret_word.each_with_index do |ele, index|
            if ele == letter
                correct_indexes_array.append(index)
            end
        end
        correct_indexes_array
    end

    #function to append the correct letter to index using correct_index_array
    def correct_letter_appendor(letter, cor_index_array)
        for i in cor_index_array
            @correct_guess_array[i] = letter
        end
    end

    #compound function to check if correct letter and then append correct letter to array
    def letter_checker_and_appendor(letter)
        cga = letter_checker(letter)
        if cga.any?
            correct_letter_appendor(letter, cga)
        end
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
puts al.secret_word

until juego.game_over == true
    let = john.all_input(juego.available_letters)
    juego.letter_deletor_and_appendor(let)
    juego.letter_checker_and_appendor(let)
    juego.game_won?
    juego.lives_reducer_and_checker
end

print juego.available_letters
puts
print juego.guessboard
puts 
print juego.correct_guess_array