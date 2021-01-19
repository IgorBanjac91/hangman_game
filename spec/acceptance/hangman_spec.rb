require 'spec_helper'
require_relative '../../lib/hangman'

module Hangman
  RSpec.describe 'Hangman Game' do 
    it 'plays the game' do 
      game = Game.new
      game.play
    end
  end
end