require_relative '../lib/hangman'

def display_savings
  File.foreach("savings.txt") do |line|
    saving_hash = JSON.parse(line)
    puts "#{$.} - #{saving_hash['saving_date']}"
  end
end

def load_saving
  puts "Choose from one of your saves"
  display_savings
  save_num = gets.chomp.to_i - 1
  save_file = File.read("savings.txt").split("\n")
  save = JSON.parse(save_file[save_num])
  save = save["data"].transform_keys(&:to_sym)
  board_drawing = save.delete(:board_drawing)
  inputs_game = save.merge(board: Hangman::Board.new( { drawing: board_drawing } ))
  game = Hangman::Game.new(inputs_game)
  game.play
end


puts "    HANGMAN     "
puts "\nSelect:"
puts "\n1 - New Game"
puts "\n2 - Continue\n"
puts "----------------"

mode = gets.chomp.to_i
until mode == 2 || mode == 1
  puts "Wrong input, chose a number from 1 and 2"
  mode = gets.chomp.to_i
end
if mode == 1
  game = Hangman::Game.new word: "igore"
  game.play
else mode == 2
  load_saving
end




