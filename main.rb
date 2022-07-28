# frozen_string_literal: true
require './game'

loop do
  Game.new_game
  Game.update
  print 'Do you want to play again [y/n]?'
  play_again = gets.chomp until %w[y n Y N].include?(play_again)

  break if play_again.downcase == 'n'
end
