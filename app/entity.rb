class Dijkstra
  attr_accessor :goals, :grid
  
  def initialize args
    self.goals = []
    self.grid = {}
    end

    def get_move(x,y)
      best = 100
      bx, by = 0,0
      [y-1,y,y+1].each do |ny|
        [x-1,x,x+1].each do |nx|
          if nx != x or ny != y
            if (self.grid[(x,y)]||100) < best
              best = self.grid[(x,y)]
              bx = nx
              by = ny
          end
        end
      end
      bx, by
    end

    def in_fov(x,y)
      (abs(x - self.x) + abs(y - self.y)) < 10
    end

    def calc_map()
      visited = Set.new
      q = Queue.new
      q.push((self.x, self.y))
      while not q.empty?
        x,y = q.pop()
        v = self.grid[(x,y)]
        visited.add((x,y))
        [y-1,y,y+1].each do |ny|
          [x-1,x,x+1].each do |nx|
            if (nx,ny) not in visited:
              g = self.grid[(nx,ny)]||100
              self.grid[(nx,ny)] = [v+1,g].min
              if in_fov(nx, ny)
                q.push((nx, ny))
              end
            end
          end
      end
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
