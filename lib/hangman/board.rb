
module Hangman
  class Board
    attr_accessor :drawing
    def initialize
      @drawing = default_drawing
    end
     
    def default_drawing
      [[' ', '_', '_', '_', '_'], 
       [' ', '|', ' ', ' ', '|'], 
       [' ', ' ', ' ', ' ', '|'],
       [' ', ' ', ' ', ' ', '|'],
       [' ', ' ', ' ', ' ', '|'],
       [' ', ' ', ' ', ' ', '|'],
       ['_', '_', '_', '_', '|']]
    end

    def add_piece
      drawing[2, 0] = '\\' if drawing[2][0].empty?  
      drawing
    end

    def display_drawing
      drawing.each { |line| puts "    " + line.join}
    end
  end
end