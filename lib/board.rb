require 'pry'

class Board
  
  attr_accessor :cells
  
  def initialize
    self.reset!
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
  
  def position(input)
    int = input.to_i - 1
    if int >= 0 && int <= 8
      @cells[int]
    end
  end
  
  def full?
    !@cells.any?{|cell| cell == "" || cell == " "}
  end
  
  def turn_count
    occupied = 0
    @cells.each do |cell|
      if cell != " "
        occupied += 1
      end
    end
    occupied
  end
  
  def taken?(input)
    int = input.to_i - 1
    !(@cells[int].nil? || @cells[int] == " ")
  end
  
  def valid_move?(input)
    int = input.to_i - 1
    ((int >= 0 && int <= 8) && !taken?(input))
  end
  
  def token
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  def update(num, player_object)
    int = num.to_i - 1
    @cells[int] = token
  end
  
end