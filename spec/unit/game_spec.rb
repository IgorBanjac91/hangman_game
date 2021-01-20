require 'spec_helper'
require_relative '../../lib/hangman'

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
      context 'when correct'
    end
  end
end