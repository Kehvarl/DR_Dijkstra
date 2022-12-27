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

  def get_move()
    best = 100
    bx, by = 0,0
    [self.y-1,self.y,self.y+1].each do |y|
      [self.x-1,self.x,self.x+1].each do |x|
        if x != self.x or y != self.y
          if (self.grid[(x,y)]||100) < best
            best = self.grid[(x,y)]
            bx = x
            by = y
        end
      end
    end
    bx, by
end
