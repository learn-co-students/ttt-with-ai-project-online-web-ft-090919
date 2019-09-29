class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    board.turn_count.even? ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.find do |wincon|
      #get all unique pieces in the relevent positions
      pieces = wincon.map { |index| board.cells[index] }.uniq
      #If the length is 1 then all the pieces have the same value, if the value isn't blank than someone has won
      pieces.length == 1 && pieces.first != " "
    end
  end

  def draw?
    board.full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    #If won isn't nill, return the winning piece, else nill
    !!won? ? board.cells[won?.first] : nil
  end

  def turn
    player = current_player
    move = player.move(@board)

    while !@board.valid_move?(move)
      move = player.move(@board)
    end

    if @board.valid_move?(move)
      @board.update(move, player)
    end

  end

  def play
    while !over?
      @board.display
      turn
    end
    @board.display

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

  def self.start

    puts "Welcome to Tic Tac Toe"

    number_of_players = "A"

    while !number_of_players.to_i.between?(0,2) || !!number_of_players.match(/\D/) || number_of_players == ""

      print "How many Human Players?: "
      number_of_players = gets.chomp

    end

    number_of_players = number_of_players.to_i

    if number_of_players == 0
      player_1 = Players::Computer.new("X")
      player_2 = Players::Computer.new("O")

    elsif number_of_players == 1
      print "Should the Human or Computer Go First?(h or c):"
      input = ""
      until input == "h" || input == "c"
        input = gets.chomp.downcase
      end

      if input == "h"
        player_1 = Players::Human.new("X")
        player_2 = Players::Computer.new("O")

      else
        player_1 = Players::Computer.new("X")
        player_2 = Players::Human.new("O")

      end

    elsif number_of_players == 2
      player_1 = Players::Human.new("X")
      player_2 = Players::Human.new("O")

    end

    self.new(player_1, player_2).play

  end

end
