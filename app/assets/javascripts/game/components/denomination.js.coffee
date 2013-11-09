Crafty.c 'Denomination',
  init: ->
    @requires('2D, DOM, Image, ScaleableImage')
     .origin('center')
     .attr(z: 300)
    @

  denomination: (denomination) ->
    @_denomination = denomination
    @image(@_imageMapping[denomination])

  _imageMapping:
    1: Game.images.oneCent
    5: Game.images.fiveCent
    10: Game.images.tenCent
    50: Game.images.fiftyCent
    100: Game.images.oneDollar
    500: Game.images.fiveDollar
    1000: Game.images.tenDollar