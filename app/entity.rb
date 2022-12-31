class Dijkstra
  attr_accessor :w, :h, :goals, :grid

  def initialize args
    self.w = args.w || 10
    self.h = args.h || 10
    self.goals = []
    self.grid = {}
  end


  def in_map(x,y)
    (0 <= x < self.w) && (0 <= y < self.h)
  end

  def calc_map
    visited = {}
    q = []
    q << self.goals[0]
    while q.length > 0
      x,y = q.shift()
      v = self.grid[[x,y]]
      visited[[x,y]] = 0
      [y-1,y,y+1].each do |ny|
        [x-1,x,x+1].each do |nx|
          if !visited.has_key?([x,y])
            #g = (self.grid & [[x,y]]).first || 100
            self.grid[[nx,ny]] = v + 1
            if in_map(nx, ny)
              q << [nx, ny]
            end
          end
        end
      end
    end
  end

  def render
    out = []
    (0..self.h).each do |y|
      (0..self.w).each do |x|
        if self.grid.has_key?([x,y])
          c = self.grid[[x,y]]
        else
          c = 255
        end
        out << [x*16+640,y*16+320,16,16,c,c,c]
      end
    end
    out
  end
end

class Entity
  attr_sprite
  def initialize args
    self.w = args.w || 32
    self.h = args.h || 32
    self.x = args.x || 0
    self.y = args.y || 0
    self.path = args.path || 'sprites/circle/orange.png'
    self.goals = []
    self.grid = {}
  end
end
