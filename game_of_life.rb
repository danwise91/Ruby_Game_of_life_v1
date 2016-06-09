#the basic file

#can create a gaming world with cells that are both alive and dead
#make cells interact
class Game
  attr_accessor :world, :seeds
  #seeds must contain smaller arrays
  def initialize(world=World.new, seeds=[])
    @world = World.new
    @seeds = []
    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end

  def tick!
    world.cells.each do |cell|
      if cell.alive? and world.live_neighbours_around_cell(cell).count < 2
          cell.die!
      end

      #rule 1
    end
  end
end
#testing 
class World
  attr_accessor :rows, :cols, :cell_grid, :cells

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []
    #[[Cell.new, Cell.new, Cell.new]
    # [Cell.new, Cell.new, Cell.new]
    # [Cell.new, Cell.new, Cell.new]]
      @cell_grid = Array.new(rows) do |row|
                  Array.new(cols) do |col|
                    cell = Cell.new(col, row)
                    cells << cell
                    cell
                 end
              end
  end

  def live_neighbours_around_cell(cell)
    live_neighbors = []
    # Neighbour to the North-East
    if cell.y > 0 and cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y - 1][cell.x + 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbour to the South-East
    if cell.y < (rows - 1) and cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x + 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbors to the South-West
    if cell.y < (rows - 1) and cell.x > 0
      candidate = self.cell_grid[cell.y + 1][cell.x - 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbors to the North-West
    if cell.y > 0 and cell.x > 0
      candidate = self.cell_grid[cell.y - 1][cell.x - 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbour to the North
    if cell.y > 0
      candidate = self.cell_grid[cell.y - 1][cell.x]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbour to the East
    if cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y][cell.x + 1]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbour to the South
    if cell.y < (rows - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x]
      live_neighbors << candidate if candidate.alive?
    end
    # Neighbors to the West
    if cell.x > 0
      candidate = self.cell_grid[cell.y][cell.x - 1]
      live_neighbors << candidate if candidate.alive?
    end


    live_neighbors
  end
end

class Cell
  attr_accessor :alive, :x, :y

  def initialize(x=0, y=0)
    @alive = false
    @x = x
    @y = y
  end

  def alive?; alive; end

  def dead?; !alive; end

  def die!
    @alive = false
  end
end
