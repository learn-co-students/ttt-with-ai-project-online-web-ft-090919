class Board
  
  attr_accessor :cells
 
 
  def initialize
    self.cells = Array.new(9, " ")
  end
  
  def turn_count
    self.cells.count{|token| token == "X" || token == "O"}
    binding.pry
  end
 
  def full?
    self.cells.all? {|cell| cell != " "}
  end
 
  def position(input)
    self.cells[input.to_i.-1]
  end
 
  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end
 
  def reset!
    self.cells = Array.new(9, " ")
  end
  
end