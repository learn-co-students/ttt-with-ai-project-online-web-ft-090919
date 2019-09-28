module Players

  class Human < Player
    def move(board)
      puts "Enter Position to Place Piece: "
      gets.chomp
    end
  end
end
