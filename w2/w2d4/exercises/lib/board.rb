class Board
  attr_reader :grid, :marks
  
  def self.blank_grid
    Array.new(3) {Array.new(3)}
  end
  
  def initialize(grid = Board.blank_grid)
    @grid = grid
    @marks = [:X,:O]
  end
  
  def [](pos) ##why?
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value) ##why?
    row, col = pos
    grid[row][col] = value
  end
  
  def place_mark(pos,mark)
    self[pos] = mark if empty?(pos)
  end
  
  def empty?(pos)
    self[pos].nil?
  end
  
  def winner #need explanation
    (grid + cols + diagonals).each do |triple|
      return :X if triple == [:X, :X, :X]
      return :O if triple == [:O, :O, :O]
    end

    nil
  end

  def cols #need explanation
    cols = [[], [], []]
    grid.each do |row|
      row.each_with_index do |mark, col_idx|
        cols[col_idx] << mark
      end
    end
    cols
  end
  
  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]
    [down_diag, up_diag].map do |diag|
      diag.map { |row, col| grid[row][col] }
    end
  end
  
  def over?
    winner || @grid.flatten.none? {|pos| pos.nil?}
  end
end