require 'spec_helper'
require_relative '../../lib/hangman'

module Hangman
  
  RSpec.describe Board do 

    let(:starting_drawing) { [[' ', '_', '_', '_', '_'], 
                              [' ', '|', ' ', ' ', '|'], 
                              [' ', ' ', ' ', ' ', '|'],
                              [' ', ' ', ' ', ' ', '|'],
                              [' ', ' ', ' ', ' ', '|'],
                              [' ', ' ', ' ', ' ', '|'],
                              ['_', '_', '_', '_', '|']]}

    describe '#initialize' do 
      it 'initialize the board with a default drawing' do
        board = Board.new
        expect(board.drawing).to eq(starting_drawing)
      end
    end

    describe '#add_piece' do
        it 'adds the head when the first mistake is made' do 
          board = Board.new
          board.add_piece
          expect(board.drawing).to  eq([[' ', '_', '_', '_', '_'], 
                                        [' ', '|', ' ', ' ', '|'], 
                                        [' ', '0', ' ', ' ', '|'],
                                        [' ', ' ', ' ', ' ', '|'],
                                        [' ', ' ', ' ', ' ', '|'],
                                        [' ', ' ', ' ', ' ', '|'],
                                        ['_', '_', '_', '_', '|']] )
        end

        it 'completes the drawing after 6 added pieces' do
          board = Board.new
          6.times { board.add_piece }
          expect(board.drawing).to eq([[' ', '_', '_', '_', '_'], 
                                       [' ', '|', ' ', ' ', '|'], 
                                       ["\\", '0', '/', ' ', '|'],
                                       [' ', '|', ' ', ' ', '|'],
                                       ['/', ' ', "\\", ' ', '|'],
                                       [' ', ' ', ' ', ' ', '|'],
                                       ['_', '_', '_', '_', '|']] )
      end
    end

    describe '#reset the board' do 
      it 'restore the board to its default' do 
        board = Board.new
        5.times { board.add_piece }
        board.reset
        expect(board.drawing).to eq(starting_drawing)
      end
    end

    describe '#game_over' do 
      it 'returns the symbol :winner if winner? true' do
        board = Board.new
        allow(board).to receive(:winner?).and_return true
        expect(game_over).to eq(:winner)
      end
    end
  end
end