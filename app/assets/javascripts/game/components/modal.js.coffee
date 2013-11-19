Crafty.c 'Modal',

  init: ->
    @requires('Tween, 2D, DOM').attr(x:0, y:0, w:Config.window.width, h:Config.window.height, z:520)
    @alpha = 0
    @tween({alpha: 1}, 100)
