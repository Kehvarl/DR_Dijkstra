def tick args
  args.state.gmap ||= GameMap.new({})
  args.state.d ||= Dijkstra.new({game_map: args.state.gmap, goals: [[9,9], [1,1], [29,9]]})
  if args.tick_count <= 0
    p "loading"
    args.state.gmap.loadfile('mygame/data/map.dat')
    p "calculating"
    args.state.d.calc_map
    p "done"
  end
  if args.inputs.keyboard.key_up.r
    p "calculating"
    args.state.d.calc_map
    p "done"
  end
  overlay = args.state.gmap.render_map(args.state.d)
  args.outputs.primitives  << args.state.gmap.render()
  args.outputs.primitives << overlay
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
