def tick args
  args.state.gmap ||= GameMap.new({})
  args.state.d ||= Dijkstra.new({goals: [[0,5]]})
  if args.tick_count <= 0
    args.state.gmap.loadfile('app/map.dat')
    args.state.d.game_map = args.state.gmap
  end
  args.outputs.primitives  << args.state.gmap.render()
end

# TODO: Create Game Map
# TODO: Create Movable Entity
# TODO: Create Goals
# TODO: Create FoV
# TODO: Dijkstra Map
# TODO: Use DM to move E to each goal in view


#def tick args
#  args.state.d ||= Dijkstra.new({goals: [[0,5]]})
#  args.state.d.calc_map()
#  args.outputs.solids << args.state.d.render()
#end
