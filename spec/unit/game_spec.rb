require 'spec_helper'
require_relative '../../lib/hangman'
require 'stringio'

module Hangman
  RSpec.describe Game do
    let(:starting_drawing) { [[' ', '_', '_', '_', '_'], 
                              [' ', '|', ' ', ' ', '|'], 
                              [' ', ' ', ' ', ' ', '|'],
                              [' ', ' ', ' ', ' ', '|'],
                              [' ', ' ', ' ', ' ', '|'],
                              [' ', ' ', ' ', ' ', '|'],
                              ['_', '_', '_', '_', '|']] }

    let(:game) { Game.new }
    let(:new_game) { Game.new word: "example"}
  
    describe '#initialize' do 
      context "when correctly initialized" do
        it 'sets the game with a new board' do 
          game
          expect{game.board}.to_not raise_error
        end

        it 'sets the guessing line with an array with teh same size as the word to guess' do 
          game
          guessing_line = game.guessing_line
          word_to_guess = game.word_to_guess
          expect(word_to_guess.size).to be(guessing_line.size)
        end

        it 'sets the guessing line with underscores' do 
          game
          expect(game.guessing_line).to all( eq('_'))
        end
      end
    end

    describe '#random_word_from_dictionary' do
      it 'returns a word between 5 and 12 characters' do 
        game
        file_name = "dictionary.txt"
        word = game.random_word_from_dictionary(file_name)
        expect(word.size).to be_between(5, 12).inclusive
      end
    end

    describe '#guess_character' do
      context "when the charcater doesn't match the word to guess characters" do 
        it 'adds the character to the wrong guessed characters instance variable' do
          new_game.guess_character("z")
          expect(new_game.wrong_guessed_characters).to include("z")
        end

        it 'adds a piece to the drawing' do 
          new_game.guess_character("z")
          board = new_game.board
          head_part = board.drawing[2][1]
          expect(head_part).to eq('0')
        end
      end

      context 'when the character match the word to guess characters' do 
        it 'switchs the undersocre of the guessing line with the charcter an puts it on the right position' do
          new_game.guess_character("e") 
          expect(new_game.guessing_line).to eq(["e", "_", "_", "_", "_", "_", "e"])
        end
      end
    end

    describe '#game_over' do 
      it 'returns :win if the player has guessed the word' do 
        new_game
        new_game.guessing_line = "example".chars
        expect(new_game.game_over).to eq(:win)
      end

      it 'returns :lost if the player has finished the moves' do 
        new_game
        6.times { new_game.board.add_piece }
        expect(new_game.game_over).to eq(:lose)
      end
    end
  end
end