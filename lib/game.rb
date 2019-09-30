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
      puts "$$$$$$$$$$$"
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
    input = nil

    while !input || (input != "y" && input != "n")
      puts "Would you like to watch wargame mode? y/n"
      input = gets.strip.downcase
    end

    if input == "y"
      play_wargame
    else
      play_game
    end
  end

  private
  def self.play_game
    number_of_players = nil

    while !number_of_players || !number_of_players.to_i.between?(0,2) || !!number_of_players.match(/\D/)
      print "How many Human Players?: "
      number_of_players = gets.chomp
    end

    number_of_players = number_of_players.to_i

    if number_of_players == 0
      player_1 = Players::Computer.new("X")
      player_2 = Players::Computer.new("O")

    elsif number_of_players == 1
      print "Should the Human or Computer Go First?(h or c):"
      input = nil
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

  def self.play_wargame
      times = nil
      while !times || (times.match(/\D/) || !(times.to_i > 0))
        puts "How many games would you like to run?"
        times = gets.strip
      end

      start = Time.now
      res = times.to_i.times.reduce({w: 0, l: 0, d: 0}) do |track, i|
        g = Game.new(Players::Computer.new("X"), Players::Computer.new("O"))
        g.play
        if g.won?
          if g.winner == x
            track[:w] += 1
          else
            track[:l] += 1
          end
        else
          track[:d] += 1
        end
        track
      end
      tend = Time.now
      puts "Player 1 won #{res[:w]}"
      puts "Player 2 won #{res[:l]}"
      puts "#{res[:d]} ties"
      puts "Took #{start - tend} seconds"
  end
end
