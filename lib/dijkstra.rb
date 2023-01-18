# Dijkstra Map Calculator
# Expects:
#   game_map:  an object representing your game map.
#     Must implement:
#       in_map:  function accepting x, and y, and returns if the
#                provided coordinate is a valid destination.
#       w: Width of the map in destination nodes
#       h: Height of the map in nodes
#  goals: An array of [x,y] pairs representing desireable locations
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

  # Returns true if the given x,y position is a valid destination
  def in_map(x,y)
    if self.game_map
      self.game_map.in_map(x,y)
    else
      x.between?(0, self.w) and y.between?(0, self.h)
    end
  end

  # Recalculate the Dijkstra Map.
  def calc_map
    nodes = goals.length
    self.grid = {}
    visited = {}
    q = []
    self.goals.each do |(gx,gy)|
      q.push([0, gx, gy])
      visited[[gx,gy]] = true
    end

    while q.length > 0
      score, x, y = q.shift()
      visited[[x,y]] = true
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
          if !visited.has_key?([nx,ny]) or revisit
            q.push([score + 1, nx, ny])
            nodes +=1
          end
        end
      end
    end
    puts(nodes)
  end

  # Given an x,y coordinate, return a list of possible next coordinates that are closer to a goal
  def get_moves x,y
    best = []
    lowest = grid[[x,y]] || 100
    [[-1,0],[1,0],[0,-1],[0,1]].each do |(dx,dy)|
      nx = x + dx
      ny = y + dy
      if grid.has_key?([nx,ny])
        if grid[[nx,ny]] < lowest
          best = [[nx,ny]]
          lowest = grid[[nx,ny]]
        elsif grid[[nx,ny]] == lowest
          best << [nx,ny]
        end
      end
    end
    return best
  end
end
