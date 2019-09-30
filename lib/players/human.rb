class Players::Human < Player
  def move(board)
    puts "Enter Position to Place Piece: "
    gets.chomp
  end
end
