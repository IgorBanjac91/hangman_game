module Hangman
  class Game
    attr_accessor :board, :guessing_line
    attr_reader :word_to_guess, :file_name
    def initialize(input = {})
      @board = input.fetch(:board, Board.new)
      @file_name = input.fetch(:file_name, "dictionary.txt")
      @word_to_guess = input.fetch(:word, random_word_from_dictionary(file_name))
      @guessed_characters = []
      @guessing_line = set_guessing_line
    end

    def random_word_from_dictionary(file_name)
      words = File.read(file_name).split.select { |word| word.size.between?(5, 12)  }
      random_index = rand(words.size)
      words[random_index]
    end

      private

      def set_guessing_line
        Array.new(word_to_guess.size) { "_" }
      end
  end
end