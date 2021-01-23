require 'json'

module Hangman
  class Game
    attr_accessor :board, :guessing_line, :wrong_guessed_characters
    attr_reader :word_to_guess, :file_name

    def initialize(input = {})
      @board = input.fetch(:board, Board.new)
      @file_name = input.fetch(:file_name, "dictionary.txt")
      @word_to_guess = input.fetch(:word, random_word_from_dictionary(file_name)).chars
      @wrong_guessed_characters = input.fetch(:wrong_guessed_characters, [])
      @guessing_line = input.fetch(:guessing_line, set_guessing_line)
    end

    def random_word_from_dictionary(file_name)
      words = File.read(file_name).split.select { |word| word.size.between?(5, 12)  }
      random_index = rand(words.size)
      words[random_index]
    end
      
    def guess_character(char)
      if word_to_guess.include?(char)
        word_to_guess.each_with_index do |val, index|
          if val == char
            guessing_line[index] = val
          end
        end
      else
        wrong_guessed_characters << char
        board.add_piece
      end
    end

    def display_wrong_guessed_characters
      puts wrong_guessed_characters.join(' ')
    end

    def display_guessing_line
      puts guessing_line.join(' ')
    end

    def display_game
      board.display_drawing
      puts display_guessing_line
      puts "\nWrong characters"
      puts display_wrong_guessed_characters
    end

    def game_over
      return :win if win?
      return :lose if lose?
      false
    end

    def play
      puts "\nLets start the game, Save the man!!"
      until game_over
        display_game
        puts "Chose a character or type 1 to save the game:"
        char = gets.chomp
        if char == '1'
          save_game
          break
        else
          guess_character(char)
        end
      end
      display_game
      if game_over == :win
        puts "Congratulations, You Won The Game"
      elsif game_over == :lose
        puts "GAME OVER"
      else
        puts "Game Saved!"
      end
    end

      private

      def win?
        true if word_to_guess == guessing_line
      end

      def lose?
        true if board.full?
      end

      def set_guessing_line
        Array.new(word_to_guess.size) { "_" }
      end

      def save_game
        saving = { saving_date: Time.now,
                     data: {
                       board_drawing: @board.drawing,    
                       word: @word_to_guess.join(),
                       guessing_line: @guessing_line, 
                       wrong_guessed_characters: @wrong_guessed_characters}}
        File.open("savings.txt", "a") do |f|
          f.puts saving.to_json
        end
      end
  end
end