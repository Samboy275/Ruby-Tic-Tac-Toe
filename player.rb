# frozen_string_literal: true

# class for players
class Player
  attr_reader :won

  def initialize(name, symbol, game_board)
    @name = name
    @symbol = case symbol
              when /[a-z]/
                symbol.upcase
              else
                symbol
              end
    @game_board = game_board
    @won = false
  end

  def move(index)
    @game_board.move(index, @symbol)
    @won = true if @game_board.won?
  end

  def to_s
    "#{@name} with the #{@symbol}"
  end
end

#  class for Computer Player
class Computer < Player
  def initialize(player_symbol, game_board, name = 'Computer')
    @symbol = case player_symbol
              when 'x'
                'O'
              when 'o'
                'X'
              else
                'X'
              end
    super(name, @symbol, game_board)
  end

  def move
    index = @game_board.availab_moves.sample
    puts "made move @ #{index}"
    @game_board.draw
    super(index)
  end
end
