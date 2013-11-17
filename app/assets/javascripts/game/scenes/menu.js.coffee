Crafty.scene "menu", ->
  Crafty.background('white')

  Crafty.e('BackgroundElements')
  recipet = Crafty.e('Receipt').attr(x:300, y:40, w: 360, h:600).yPos(40).heightForAnimation(600)
  logo = Crafty.e('2D, DOM, Text, Logo').text('CHANG€').textFont(size: '50px').textColor("#373838").attr(w: 360, x: 300, y: 100, z: 1001)
  Game.sfx.playRegisterOpen()

  showButton = Crafty.e("2D, Mouse, DOM, Text, Button")
    .text("Start Game")
    .textFont(size: '20px')
    .textColor("#373838")
    .attr(x: 300, y: 200, w: 360, h:20, z:1001)
    .bind('Click', -> start())

  helpButton = Crafty.e("2D, Mouse, DOM, Text, Button")
  .text("Help")
  .textFont(size: '20px')
  .textColor("#373838")
  .attr(x: 300, y: 240, w: 360, h:20, z:1001)
  .bind('Click', -> help())

  recipet.attach(logo)
  recipet.attach(showButton)
  recipet.attach(helpButton)

  startWithSpace = (e) =>
    return unless e.key == Crafty.keys['SPACE']
    start()

  start = =>
    @unbind('KeyDown', startWithSpace)
    Crafty.scene "game"

  help = =>
    # do something.

  @bind('KeyDown', startWithSpace)
  recipet.animateUp()