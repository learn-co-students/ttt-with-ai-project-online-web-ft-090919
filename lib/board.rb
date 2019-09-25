class Board
  
 attr_accessor :cells
 
 
 def initialize
  self.cells = Array.new(9, " ")
 end
 
 def reset!
   self.cells = Array.new(9, " ")
  end
  
end