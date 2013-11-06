Crafty.scene "game", ->
  Crafty.background('white')

  Game.player.set('cashOut', new Game.Cash())

  ticker = Crafty.e('Ticker').attr(x:20, y: 20)

  cashOut = Game.player.get('cashOut')
  cashInRegister = Game.player.get('cashInRegister')

  Crafty.e('CashButtons').cash(cashOut).bind('ButtonClick', (denomination) ->
    cashOut.subtract(denomination)
    cashInRegister.add(denomination)
  )
  Crafty.e('CashButtons').attr(x: 360).cash(cashInRegister).bind('ButtonClick', (denomination) ->
    cashInRegister.subtract(denomination)
    cashOut.add(denomination)
  )
