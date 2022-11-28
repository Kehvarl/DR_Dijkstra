class Tile
  attr_sprite
  def initialize args
    self.w = args.w || 32
    self.h = args.h || 32
    self.x = args.x || 0
    self.y = args.y || 0
    self.path = args.path || 'sprites/tile/wall-1111.png'
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

  def render
    self.tiles
  end
end
