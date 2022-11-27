class Tile
  attr_sprite
  def initialize args
    self.w = args.w || 32
    self.h = args.h || 32
    self.x = args.x || 0
    self.y = args.y || 0
    self.path = args.path || 'sprites/tile/wall-0000.png'
  end
end

class GameMap
  attr_accessor :w, :h

  def initialize (w, h)
    self.w = w
    self.h = h
    self.tiles = []

    (0..h).each |y|  do
      self.tiles[y] = []
      (0..w).each |x| do
        self.tiles[y][x] = Tile.new({x: x, y: x})
      end
    end
  end

  def render
    arr = []
  end
end
