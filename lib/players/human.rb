class Players::Human < Player
  def move(board)
    print "Enter Position to Place Piece: "
    gets.chomp
  end
end
