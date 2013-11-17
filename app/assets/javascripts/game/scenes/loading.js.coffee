Crafty.scene "loading", ->
  Crafty.background('black')
  Crafty.e('2D, DOM, Text').text('loading...')

  assets = _.map(Game.images, (v,k) -> v)
  Crafty.load(assets, ->
      console.log("finished loading")
      Crafty.scene('menu')
  )