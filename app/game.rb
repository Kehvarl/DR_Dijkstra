class Tile
  attr_sprite
  attr_accessor :block
  def initialize args
    self.w = args.w || 32
    self.h = args.h || 32
    self.x = args.x || 0
    self.y = args.y || 0
    self.path = args.path || 'sprites/tile/wall-1111.png'
    self.block = args.block || true
  end
end

class GameMap
  attr_accessor :w, :h, :tiles

  def initialize args
    self.w = args.w || (1280.div(32))
    self.h = args.h || (720.div(32)-1)
    self.tiles = []

    (0..h).each do |y|
      self.tiles[y] = []
      (0..w).each do |x|
        self.tiles[y][x] = Tile.new({x: x*32, y: y*32})
      end
    end
  end

  def in_map(x,y)
    x.between?(0, self.w) and y.between?(0, self.h) and (!self.tiles[y][x].block)
  end

  def loadfile filepath
    file = File.open(filepath)
    lines = file.readlines()
    lines.each_with_index do |line, line_index|
      line.chomp().split("").each_with_index do |char, char_index|
        if char == "."
          self.tiles[line_index][char_index].path = 'sprites/tile/wall-0000.png'
          self.tiles[line_index][char_index].block = false
        end
      end
    end
  end

  def render
    self.tiles
  end
end
