require_relative "board"
require "colorize"
class ComputerPlayer
    attr_reader :mark

    def initialize(board, mark)
        @board = board
        @mark = mark
    end

    def display
        new_board = Board.new
        new_board.grid = self.get_copy(@board)
        new_board
    end

    def get_move
        board = self.display
        grid = board.grid
        grid.each_with_index do |row, idx_1|
            row.each_with_index do |ele, idx_2|
                if ele == :N
                    grid[idx_1][idx_2] = @mark
                    if board.winner == @mark
                        return [idx_1, idx_2]
                    else
                        grid[idx_1][idx_2] = :N
                    end
                end
            end
        end
        grid.each_with_index do |row, idx_1|
            row.each_with_index do |ele, idx_2|
                return [idx_1, idx_2] if ele == :N
            end
        end
    end

    def get_copy(board)
        new_grid = []
        board.grid.each { |row| new_grid << row }
        new_grid
    end

end