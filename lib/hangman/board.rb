
module Hangman
  class Board
    attr_accessor :drawing
    def initialize(input = {} )
      @drawing = input.fetch(:drawing, default_drawing)
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
      if drawing[2][1] == " "
        drawing[2][1] = '0'; return
      elsif drawing[2][0] == " "  
        drawing[2][0] = "\\"; return 
      elsif drawing[2][2] == " "  
        drawing[2][2] = '/'; return  
      elsif drawing[3][1] == " "  
        drawing[3][1] = '|'; return  
      elsif drawing[4][0] == " "  
        drawing[4][0] = '/'; return
      else   
        drawing[4][2] = "\\"; return 
      end
    end

    def display_drawing
      drawing.each { |line| puts "    " + line.join}
    end

    def reset
      @drawing = default_drawing
    end

    def full?
      drawing == [[' ', '_', '_', '_', '_'], 
                  [' ', '|', ' ', ' ', '|'], 
                  ["\\", '0', '/', ' ', '|'],
                  [' ', '|', ' ', ' ', '|'],
                  ['/', ' ', "\\", ' ', '|'],
                  [' ', ' ', ' ', ' ', '|'],
                  ['_', '_', '_', '_', '|']]
    end
  end
end