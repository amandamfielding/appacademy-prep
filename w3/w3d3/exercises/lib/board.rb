class Board
  DISPLAY_HASH = {
    :x => "x", #destroyed
    :s => " ", #ship
    nil => " "  #water
  }
  
  def self.default_grid
    Array.new(10) {Array.new(10)}
  end
  
  ##WTF is this doing??
  def self.random 
    self.new(self.default_grid, true)
  end
  
  attr_reader :grid
  
  def initialize(grid = self.class.default_grid, random = false)
    @grid = grid
    randomize if random
  end
  
  def display
    header = (0..9).to_a.join("  ")
    p "  #{header}"
    grid.each_with_index {|row,i| display_row(row,i)}
  end
  
  def display_row(row,i)
    symbols = row.map {|sym| DISPLAY_HASH[sym]}.join("  ")
    p "#{i} #{symbols}"
  end
  
  def count
    grid.flatten.select {|el| el == :s}.length
  end
  
  def in_range?(pos)
    pos.all? {|el| el.between?(0,grid.length-1)}
  end
  
  def [](pos)
    row, col = pos
    grid[row][col]
  end
  
  def []=(pos, val)
    row, col = pos
    grid[row][col] = val
  end
  
  def empty?(pos=nil)
    if pos
      self[pos].nil?
    else
      count == 0
    end
  end
  
  def full?
    grid.flatten.none? {|el| el.nil?}
  end
  
  def place_random_ship
    raise "hell" if full?
    pos = random_pos
    until empty?(pos)
      pos = random_pos
    end
    self[pos] = :s
  end
  
  def randomize(count = 10)
    count.times { place_random_ship }
  end
  
  def random_pos
    [rand(grid.length),rand(grid.length)]
  end
  
  def won?
    grid.flatten.none?{|el| el == :s}
  end
end
