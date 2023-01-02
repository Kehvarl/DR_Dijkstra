#def tick args
#  args.state.gmap ||= GameMap.new({})
#  if args.tick_count <= 0
#    args.state.gmap.loadfile('app/map.dat')
#  end
#  args.outputs.primitives  << args.state.gmap.render()
#end

# TODO: Create Game Map
# TODO: Create Movable Entity
# TODO: Create Goals
# TODO: Create FoV
# TODO: Dijkstra Map
# TODO: Use DM to move E to each goal in view


def tick args
  args.state.d ||= Dijkstra.new({goals: [[5,5]]})
  args.state.d.calc_map()
  args.outputs.solids << args.state.d.render()
end
