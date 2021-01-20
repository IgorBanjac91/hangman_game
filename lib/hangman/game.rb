module Hangman
  class Game
    attr_accessor :board, :guessing_line, :wrong_guessed_characters
    attr_reader :word_to_guess, :file_name

    def initialize(input = {})
      @board = input.fetch(:board, Board.new)
      @file_name = input.fetch(:file_name, "dictionary.txt")
      @word_to_guess = input.fetch(:word, random_word_from_dictionary(file_name)).chars
      @wrong_guessed_characters = []
      @guessing_line = set_guessing_line
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
        puts "Chose a character:"
        char = gets.chomp
        guess_character(char)
      end
       
      if game_over == :win
        puts "Congratulations, You Won The Game"
      else
        puts "GAME OVER"
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
  end
end