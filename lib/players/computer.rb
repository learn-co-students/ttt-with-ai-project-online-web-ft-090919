class Players::Computer < Player
  include BoardChecking

  attr_accessor :board

  def move(board)
    minmax(board)
  end

  def random(board)
    random_move = ""

    until board.valid_move?(random_move)
      random_move = rand (1..9)
      random_move = random_move.to_s
    end
    random_move
  end

  def minmax(board)
    #If board is empty choose the center location to save time
    if board.empty?
      return "5"
    end

    #Create placeholder enemy player for minmax algo
    enemy_token = self.token == "X" ? "O" : "X"
    @enemy = Player.new(enemy_token)
    moves = minmax_moves(board, self)

    #Find the best move's index
    max = -2
    max_index = ""
    moves.each do |index, board|
      if over?(board)
        res = minmax_score(board)
        #If any move causes you to win instantly return it 
        return index if res == 1
      else
        #Else get min score of new state
        res = min(board)
      end
      if res > max
        #If score > max set new max and new max_index
        max = res
        max_index = index
      end
    end
    max_index
  end

  #Return array of boards containing all possible moves for player from starting board
  def minmax_moves(board, player)
    possible_moves = board.cells.each.with_index(1).reduce({}) do |hash, (cell, index)|
      if cell == " "
        board_clone = board.clone
        board_clone.update(index.to_s, player)
        hash[index.to_s] = board_clone
      end
      hash
    end
    possible_moves
  end

  #Scores a finished game, 1 for winning, -1 for losing, 0 for draw
  def minmax_score(board)
    if won?(board)
      if winner(board) == self.token
        1
      else
        -1
      end
    elsif draw?(board)
      0
    end
  end

  #Find score of best move self could play
  def max(board)
    #Generate moves array
    moves = minmax_moves(board, self)
    #Placeholder for max score, even the worst score is > -2
    max = -2
    out = moves.each do |index, board|
      if over?(board)
        #If board is terminal get score
        res = minmax_score(board)
        #If terminal is winning instantly return it
        return res if res == 1
      else
        #Else get worst score of new state
        res = min(board)
      end
      max = res if res > max
    end
    max
  end

  #Find the score of worst move enemy could play
  def min(board)
    #Generate all enemy moves
    moves = minmax_moves(board, @enemy)
    #Placeholder for max score, even the best score is < 2
    min = 2
    moves.each do |index, board|
      if over?(board)
        #If  board is terminal get score
        res = minmax_score(board)
        #If terminal score is losing instantly return it
        return res if res == -1
      else
        #Else get best score of new board state
        res = max(board)
      end
      min = res if res < min
    end
    min
  end
end
