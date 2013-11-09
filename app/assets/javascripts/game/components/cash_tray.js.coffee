Crafty.c 'CashTray',
  init: ->
    @requires('2D, DOM, Image, Tween')
    .image(Game.images.cashTrayOpen)
    .attr(x: 560, y: 254, z: 5)

  close: ->
    @attr(y: 254)
    .tween({y: 50}, 5)

  open: ->
    @attr(y: 50)
    .tween({y: 254}, 20)