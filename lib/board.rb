class Board
    attr_accessor :grid
    
    def initialize
        @grid = Array.new(3) { Array.new(3, :N) }
    end

    def empty?(position)
        row, col = position
        return true if @grid[row][col] == :N
        false
    end

    def place_mark(position, mark)
        if self.empty?(position)
            row, col = position
            @grid[row][col] = mark
            return true
        else
            #raise "Position has been used already"
            return false
        end
    end

    def winner

        @grid.each do |row|
           return :O if row.all? { |ele| ele == :O }
           return :X if row.all? { |ele| ele == :X }
        end

        @grid.transpose.each do |col|
            return :O if col.all? { |ele| ele == :O }
            return :X if col.all? { |ele| ele == :X }
        end

        diag_1 = [@grid[0][0], @grid[1][1], @grid[2][2]]
        diag_2 = [@grid[0][2], @grid[1][1], @grid[2][0]]

        return :O if diag_1.all? { |ele| ele == :O }
        return :X if diag_1.all? { |ele| ele == :X }

        return :O if diag_2.all? { |ele| ele == :O }
        return :X if diag_2.all? { |ele| ele == :X }

    end

    def over?
        return true if self.winner == :O || self.winner == :X
        @grid.flatten.none? { |ele| ele == :N }
    end

end