require_relative "board"
require_relative "human_player"
require_relative "computer_player"
require "colorize"
class Game

    def initialize
        @board = Board.new()
        @human = HumanPlayer.new(@board, :X)
        @computer = ComputerPlayer.new(@board, :O)
        @current_player = @human
    end

    def current_player
        @current_player
    end

    def switch_player!
        if @current_player == @human
            @current_player = @computer
            sleep 1
        else
            @current_player = @human
        end
    end

    def play_turn
        system "clear"
        @current_player.display
        position = @current_player.get_move
        @board.place_mark(position, @current_player.mark)
        system "clear"
        @human.display
        puts "thinking..." if !self.over?
    end

    def play
        until self.over? do
            self.play_turn
            self.switch_player!
        end
        winner = "\n\n"
        if @board.winner == :X
            winner += "YOU WON!".blue
        elsif @board.winner == :O
            winner += "YOU LOST!".red
        else
            winner += "Its a TIE game".green
        end
        puts winner
        puts "\n\nWould you like to play again? (Yes/No)".yellow
        if gets.chomp.downcase == "yes"
            game = Game.new
            game.play
        end
    end

    def over?
        @board.over?
    end

end

game = Game.new
game.play