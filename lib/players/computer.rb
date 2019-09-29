# module Players

class Players::Computer < Player

def move(board)

  random_move = ""

  until board.valid_move?(random_move)

    random_move = rand (1..9)
    random_move = random_move.to_s

  end

  random_move
end



end
