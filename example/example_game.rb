require_relative '../lib/hangman'

puts "    HANGMAN     "
puts "\nSelect:"
puts "\n1 - New Game"
puts "\n2 - Continue\n"

mode = gets.chomp.to_i
if mode == 1
  game = Hangman::Game.new word: "igore"
  game.play
end

## implement the save game feature
