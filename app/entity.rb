class Dijkstra
  attr_accessor :w, :h, :goals, :grid

  def initialize args
    self.w = args.w || 10
    self.h = args.h || 12
    self.goals = args.goals || []
    self.grid = {}
  end


  def in_map(x,y)
    x.between?(0, self.w) and y.between?(0, self.h)
  end

  def calc_map
    visited = []
    q = []
    self.goals.each do |goal|
      q << [0, goal[0], goal[1]]
    end

    while q.length > 0
      score, x, y = q.pop()
      visited << [x,y]

      if grid.has_key?([x,y])
        t = grid[[x,y]]
        grid[[x,y]] = [score, t].min()
      else
        grid[[x,y]] = score
      end

      [[-1,0],[1,0],[0,-1],[0,1]].each do |n|
        dx, dy = n
        nx = x + dx
        ny = y + dy
        if in_map(nx, ny)
          if !visited.include?([nx,ny])
            q << [score + 1, nx, ny]
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
