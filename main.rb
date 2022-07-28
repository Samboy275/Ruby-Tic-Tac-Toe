# frozen_string_literal: true

# 1 - make a class for board to draw the board in console
class Board
  attr_reader :game_over, :availab_moves

  # 1 - class should contain a way of storing board elements
  def initialize
    @board_elements = 9.times.map { |num| num + 1 }
    # 2 - board should have states to know the state of the game
    @game_over = false
    @availab_moves = @board_elements.map { |place| place }
  end

  def won?
    won = check_columns? || check_intersection? || check_rows?
    @game_over = true if won
    won
  end

  # 4 - should make a function to draw the board with the current elements
  def draw_board
    3.times.each do |i|
      puts "\n" unless i != 0
      3.times.each do |j|
        print '|' unless j.zero?
        print "  #{@board_elements[j + (i * 3)]}  "
      end
      puts "\n"
      puts '-' * 17 if i < 2
    end
    puts ''
  end

  # 5 - must register player movements
  def move(index, char)
    # require "pry-byebug"; binding.pry
    return false unless @availab_moves.include?(index)

    @availab_moves.delete(index)
    @board_elements[index - 1] = char
    won?
    true
  end

  private

  # 3 - class should check for winning conditions
  def check_rows?
    [0, 3, 6].each do |i|
      return true if @board_elements[i] == @board_elements[i + 1] && @board_elements[i] == @board_elements[i + 2]
    end
    false
  end

  def check_columns?
    3.times.each do |i|
      return true if @board_elements[i] == @board_elements[i + 3] && @board_elements[i] == @board_elements[i + 6]
    end
    false
  end

  def check_intersection?
    return true if @board_elements[4] == @board_elements[0] && @board_elements[4] == @board_elements[8]

    return true if @board_elements[4] == @board_elements[2] && @board_elements[4] == @board_elements[6]

    false
  end
end

# 1- Make class for players
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

# 2- class for Computer Player
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
    super(index)
  end
end

game_board = Board.new

puts 'Welcome to Tic Tac Toe, Choose number of players 1 or 2'

player_num = gets.chomp.to_i until [1, 2].include?(player_num)

print 'Enter Player 1 name: '
name = gets.chomp
print 'Enter Player 1 symbol: '
symbol = gets.chomp
player1 = Player.new(name, symbol, game_board)
player2 = nil

case player_num
when 1
  player2 = Computer.new(symbol, game_board)
else
  print 'Enter Player 2 name: '
  name = gets.chomp
  print 'Enter Player 2 symbol: '
  symbol2 = gets.chomp until symbol2 != symbol && @symbol2.empty?
  player2 = Player.new(name, symbol2, game_board)
end

puts "#{player1} vs #{player2}"
