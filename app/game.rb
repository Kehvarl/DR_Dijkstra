class GameMap
  attr_accessor :w, :h

  def initialize (w, h)
    self.w = w
    self.h = h
    self.tiles = []

    (0..h).each |y|  do
      self.tiles[y] = []
      (0..w).each |x| do
        self.tiles[y][x] = 10
      end
    end
  end

  def render
    arr = []
  end
end
