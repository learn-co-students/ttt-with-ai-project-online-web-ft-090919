module BoardChecking
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

    def won?(board = self.board)
      WIN_COMBINATIONS.find do |wincon|
        #get all unique pieces in the relevent positions
        pieces = wincon.map { |index| board.cells[index] }.uniq
        #If the length is 1 then all the pieces have the same value, if the value isn't blank than someone has won
        pieces.length == 1 && pieces.first != " "
      end
    end

    def draw?(board = self.board)
      board.full? && !won?(board)
    end

    def over?(board = self.board)
      draw?(board) || !!won?(board)
    end

    def winner(board = self.board)
      #If won isn't nill, return the winning piece, else nill
      !!won?(board) ? board.cells[won?(board).first] : nil
    end
end
