class Game

  include BoardChecking

  attr_accessor :board, :player_1, :player_2

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    board.turn_count.even? ? player_1 : player_2
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
