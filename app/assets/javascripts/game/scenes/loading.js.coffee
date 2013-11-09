Crafty.scene "loading", ->
  Crafty.background('black')
  Crafty.e('2D, DOM, Text').text('loading...')

  Crafty.load(
    _.map(Game.images, (v,k) -> v)
  , ->
      console.log("finished loading")
      Crafty.scene('game')
  )