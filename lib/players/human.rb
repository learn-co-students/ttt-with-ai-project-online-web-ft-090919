require_relative "board"
require "colorize"
class HumanPlayer
    attr_reader :mark

    def initialize(board, mark)
        @board = board
        @mark = mark
    end

    def display
        new_grid = []
        @board.grid.each do |row|
            line = []
            row.each do |ele|
                if ele == :N
                    line << "⬜️"
                elsif ele == :O
                    line << "🔴"
                elsif ele == :X
                    line << "❌"
                end
            end
            new_grid << line
        end
        new_grid.each { |sub| puts sub.join(" ") }
    end

    def get_move
        puts "Enter a position e.g. '0 0' "
        position = gets.chomp.split.map(&:to_i)
        until position.length == 2 && position[0] < 3 && position[0] >= 0 && position[1] < 3 && position[1] >= 0 && @board.empty?(position)
            puts "Invalid position"
            position = gets.chomp.split.map(&:to_i)
        end
        position
    end

end