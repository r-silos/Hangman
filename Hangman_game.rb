require 'yaml'

class Game
    attr_reader :available_letters, :guessboard, :correct_guess_array, :game_over, :secret_word, :lives, :game_won

    def initialize
        @lives = 6
        #@correct_guessboard = []
        @guessboard = []
        @available_letters = alphabet_loop()
        @secret_word = ''
        @game_over = false
        @game_won = false
        @incorrect_guess_array = []
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
    def lives_checker
        if @lives == 0
            @game_over = true
        end
    end

    #function to check if game was won
    def game_won?
        #puts "The correct_guessboard is #{@correct_guess_array}"
        #puts "the secret word is #{@secret_word}"
        
        if @correct_guess_array == @secret_word
            @game_over = true
            @game_won = true
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
    def letter_checker_and_appendor_and_life_reducer(letter)
        cga = letter_checker(letter)
        if cga.any?
            correct_letter_appendor(letter, cga)
        else 
            @lives -= 1
            @incorrect_guess_array.append(letter)
        end
    end
=begin
    Display function needs to show the lives remaining, correct letters chosen and pos in
    word, and which incorrect letters have already been chosen
=end

    #display function updates player on game essential info
    def display
        puts "The number of lives left is #{@lives}"
        puts "The incorrct letters chosen are #{@incorrect_guess_array}"
        puts "The current gameboard is #{@correct_guess_array}"
    end

    # fucntion to create the hash with game essential info that will be saved and loaded
    def essential_hash_info
        info = {
            :secret => @secret_word,
            :lifes => @lives,
            :correct_guess_array => @correct_guess_array,
            :guessboard => @guessboard
        }
        return info
    end
    # function used to save essential info into yaml file
    def save_game
        save_data = essential_hash_info()
        output = File.open('surve_game.yaml', 'w')
        YAML.dump(save_data,output)
    end
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
let = john.all_input(juego.available_letters)
juego.letter_deletor_and_appendor(let)
juego.letter_checker_and_appendor_and_life_reducer(let)
juego.display
juego.game_won?
juego.lives_checker
juego.save_game

=begin

until juego.game_over == true
    let = john.all_input(juego.available_letters)
    juego.letter_deletor_and_appendor(let)
    juego.letter_checker_and_appendor_and_life_reducer(let)
    juego.display
    juego.game_won?
    juego.lives_checker
end

if juego.game_won == true
    puts "\nHoly shit, you won the game!"
else
    puts "\nTF, You lost! Embarassing!"
end
OBJ for next time
-Work on essential_hash_info func that is used to create a hash
that will be passed onto the YAML file for saving and loading
-Work on Yaml Load File
-Work on Yaml Save file
-Work to incorprate saving and loading game into game flow

=end