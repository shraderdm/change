Crafty.scene "menu", ->
  Crafty.background('white')

  Crafty.e('BackgroundElements')
  recipet = Crafty.e('Receipt').attr(x:300, y:40, w: 360, h:600).yPos(40).heightForAnimation(600).animateUp()
  recipet.attach(Crafty.e('2D, DOM, Image').image(Game.images.logo).attr(x: 407, y: 720, z: 1000))

  Game.sfx.playRegisterOpen()

  showButton = ->
    Crafty.e("2D, Mouse, DOM, Text, Button").text("Start Game").attr(x: -130, y: 50, w: 260, h:42).bind('Click', ->
      start()
    )

  startWithSpace = (e) =>
    return unless e.key == Crafty.keys['SPACE']
    start()

  start = =>
    @unbind('KeyDown', startWithSpace)
    Crafty.scene "game"

  @bind('KeyDown', startWithSpace)