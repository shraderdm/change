Crafty.scene "menu", ->
  Crafty.background('white')

  Crafty.e('BackgroundElements')
  Crafty.e('Receipt').attr(x:300, y:40, w: 360, h:600).yPos(40).heightForAnimation(600).animateUp()
  Game.sfx.playRegisterOpen()