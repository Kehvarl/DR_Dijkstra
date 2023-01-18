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

class SolidTile
  attr_accessor :w, :h, :x, :y, :r, :g, :b, :a, :block, :x2, :y2, :x3, :y3, :blendmode_enum
  
  def initialize args
    self.w = args.w || 32
    self.h = args.h || 32
    self.x = args.x || 0
    self.y = args.y || 0
    
    self.r = args.r || 0
    self.g = args.g || 0
    self.b = args.b || 0
    self.a = args.a || 255

    if args.value
      self.setcolor(args.value)
    end

    self.block = args.block || true
  end

  def setcolor value
    self.g = (255-(value*3))
    self.r = value*2
    self.a = 128
  end

  def primitive_marker
    :solid
  end  
end

class LabelTile
  attr_accessor :x, :y, :text, :size_enum, :alignment_enum, :vertical_alignment_enum, :blendmode_enum, :font, :r, :g, :b, :a, :block

  def initialize args
    self.x = args.x || 0
    self.y = args.y || 0
    self.r = args.r || 255
    self.g = args.g || 255
    self.b = args.b || 255
    self.size_enum = args.size || 1
    self.alignment_enum = 1
    self.text = args.text || "0"
    self.block = args.block || true
  end

  def primitive_marker
    :label
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
        self.tiles[y][x] = Tile.new({x: x*32, y: y*32, r:128, g:128, b:128})
      end
    end
  end

  def in_map(x,y)
    x.between?(0, self.w) and y.between?(0, self.h) and (!self.tiles[y][x].block)
  end

  def loadfile filepath
    f = File.open(filepath)
    lines = f.readlines()
    f.close()
    lines.each_with_index do |line, line_index|
      line.chomp().split("").each_with_index do |char, char_index|
        if char == "."
          self.tiles[line_index][char_index].path = 'sprites/tile/wall-0000.png'
          self.tiles[line_index][char_index].block = false
        end
      end
    end
    self.regen_sprites
  end

  def get_sprite (x,y)
    if self.tiles[y][x].block
      return "0000"
    end
    #TRBL
    val = "0000"
    if y == 0 or self.tiles[y-1][x].block # Bottom
      val[2] = "1"      
    end
    if y >= self.h-1 or self.tiles[y+1][x].block #Top
      val[0] = "1"      
    end
    if x == 0 or self.tiles[y][x-1].block # Left
      val[3] = "1"
    end
    if x >= self.w-1 or self.tiles[y][x+1].block # Right
      val[1] = "1"
    end
    val
  end

  def regen_sprites
    (0..h).each do |y|
      (0..w).each do |x|
        self.tiles[y][x].path = "sprites/tile/wall-#{get_sprite(x,y)}.png"
      end
    end
    
  end

  def render
    self.tiles
  end

 
  # Draws the dijkstra map onto the screen - move to map routine
  def render_map dijkstra
    overlay = []
    dijkstra.grid.each do |node, score|
      x,y = node
      overlay << SolidTile.new({x:x*32, y:y*32, value:score, block:false})
      overlay << LabelTile.new({x: (x*32)+16, y: (y*32)+32, text: score, block:false})
    end
    overlay
  end 
end
