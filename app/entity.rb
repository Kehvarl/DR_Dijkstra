class Dijkstra
  attr_accessor :w, :h, :goals, :grid, :game_map

  def initialize args
    self.game_map = args.game_map || false
    if game_map
      self.w = self.game_map.w
      self.h = self.game_map.h
    else
      self.w = args.w || 10
      self.h = args.h || 12
    end
    self.goals = args.goals || []
    self.grid = {}
  end


  def in_map(x,y)
    if self.game_map
      self.game_map.in_map(x,y)
    else
      x.between?(0, self.w) and y.between?(0, self.h)
    end
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
      revisit = false
      if grid.has_key?([x,y])
        t = grid[[x,y]]
        revisit = (t > score)
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

  def render_map
    (0..self.h).each do |y|
      (0..self.w).each do |x|
        if in_map(x,y) and self.grid.has_key?([x,y])
          c = self.grid[[x,y]]
          self.game_map.tiles[y][x].b = c  * 16
          self.game_map.tiles[y][x].g = c*16 #- (c * 1 % 255)
          self.game_map.tiles[y][x].r = c*16 #- (c * 1 % 255)
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
        out << [x*16+640,y*16+320,16,16,c*16%255,c*8%255,c]
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
