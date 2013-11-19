class Sudoku
  attr_reader :grid

  def initialize(board_string)
    @grid = board_string.split('').map {|x| x.to_i }.each_slice(9).to_a
    @row = 0
    @column = 0
    @answer_string = "0"
  end

  def get_row(index)
    @grid[index]
  end

  def get_column(index)
    column = []
    @grid.each {|row| column << row[index]}
    column
  end

  def get_mini_grid(row, column)
    if row.between?(0,2)
      if column.between?(0,2)
        mini_grid_0 = @grid[0][0..2] + @grid[1][0..2] + @grid[2][0..2]
      elsif column.between?(3,5)
        mini_grid_1 = @grid[0][3..5] + @grid[1][3..5] + @grid[2][3..5]
      elsif column.between?(6,8)
        mini_grid_2 = @grid[0][6..8] + @grid[1][6..8] + @grid[2][6..8]
      end
    elsif row.between?(3,5)
      if column.between?(0,2)
        mini_grid_3 = @grid[3][0..2] + @grid[4][0..2] + @grid[5][0..2]
      elsif column.between?(3,5)
        mini_grid_4 = @grid[3][3..5] + @grid[4][3..5] + @grid[5][3..5]
      elsif column.between?(6,8)
        mini_grid_5 = @grid[3][6..8] + @grid[4][6..8] + @grid[5][6..8]
      end
    elsif row.between?(6,8)
     if column.between?(0,2)
      mini_grid_6 = @grid[6][0..2] + @grid[7][0..2] + @grid[8][0..2]
    elsif column.between?(3,5)
      mini_grid_7 = @grid[6][3..5] + @grid[7][3..5] + @grid[8][3..5]
    elsif column.between?(6,8)
      mini_grid_8 = @grid[6][6..8] + @grid[7][6..8] + @grid[8][6..8]
    end
  end
end

def solve!
  @row = 0
  @column = 0
  one_dimensional_grid = @grid.flatten
  one_dimensional_grid.map! do |element|
    if element == 0
      possibilities = (1..9).to_a
      possibilities = possibilities - (get_row(@row) + get_column(@column) + get_mini_grid(@row,@column))
      if possibilities.length == 1
        (element = possibilities[0])
      else
        (element = element)
      end
    end
    @row += 1 if @column == 8
    @column < 8 ? (@column += 1) : (@column = 0)
    element
  end
  @grid = one_dimensional_grid.each_slice(9).to_a
  one_dimensional_grid.join("")
end

def recursive_solve!
  while @grid.flatten.join.include?('0')
    self.solve!
  end
end

def board
  @answer_string = @grid.each {|row| row.join}.join
end
end


my_sudoku = Sudoku.new('619030040270061008000047621486302079000014580031009060005720806320106057160400030')

my_sudoku.recursive_solve!