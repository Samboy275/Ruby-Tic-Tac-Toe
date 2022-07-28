# frozen_string_literal: true

require './board'
require './player'

# module for the game
module Game
  def self.new_game
    @game_board = Board.new
    puts 'Welcome to Tic Tac Toe, Choose number of players 1 or 2'

    player_num = gets.chomp.to_i until [1, 2].include?(player_num)
    print 'Enter Player 1 name: '
    name = gets.chomp
    print 'Enter Player 1 symbol: '
    symbol = gets.chomp
    @player1 = Player.new(name, symbol, @game_board)
    @player2 = nil

    case player_num
    when 1
      @player2 = Computer.new(symbol, @game_board)
    else
      print 'Enter Player 2 name: '
      name = gets.chomp
      print 'Enter Player 2 symbol: '
      symbol2 = ''
      while symbol2.empty?
        symbol2 = gets.chomp until symbol2 != symbol && !symbol2.strip.empty?
        symbol2 = symbol2.strip
      end
      @player2 = Player.new(name, symbol2, @game_board)
    end

    puts "#{@player1} vs #{@player2}"
  end

  def self.update
    @game_board.draw
    until @game_board.game_over

      print "#{@player1} enter your move: "
      player1_move = gets.chomp.to_i until @game_board.availab_moves.include?(player1_move)
      @player1.move(player1_move)

      @game_board.draw
      if @player1.won
        puts "#{@player1} won the game!!!"
        return
      end
      if @player2.is_a?(Computer)
        @player2.move
      else
        print "#{@player2} enter your move: "
        player2_move = gets.chomp.to_i until @game_board.availab_moves.include?(player2_move)
        @player2.move(player2_move)
      end
      @game_board.draw
      if @player2.won
        puts "#{@player2} won the game !!!"
        return
      end
    end

    puts 'Draw!! no more available moves'
  end
end
