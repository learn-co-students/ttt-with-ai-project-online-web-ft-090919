class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(index)
    @cells[input_to_index(index)]
  end

  def full?
    @cells.all? { |cell| cell == "X" || cell == "O"}
  end

  def empty?
    @cells.all? { |cell| cell == " " }
  end

  def turn_count
    @cells.reduce(0) { |turn_count, cell| cell != " " ? turn_count + 1 : turn_count }
  end

  def taken?(index)
    @cells[input_to_index(index)] != " "
  end

  def valid_move?(input)
    input_to_index(input).between?(0, 8) && !taken?(input)
  end

  def update(input, player)
    @cells[input_to_index(input)] = player.token
  end

  def clone
    self.class.new_with_cells(@cells.dup)
  end

  def self.new_with_cells(cells)
    board = self.new
    board.cells = cells
    board
  end

  private
  def input_to_index(input)
    input.to_i - 1
  end
end
