Crafty.scene "game", ->
  Crafty.background('white')



  round = new Game.Round(player: Game.player)
  cashOut = round.get('cashOut')
  cashInRegister = Game.player.get('cashInRegister')

  Crafty.e('CashButtons').attr(x: 160).cash(round.get('customer').get('paid'))

  Crafty.e('CashButtons').cash(cashOut).bind('ButtonClick', (denomination) ->
    cashOut.subtract(denomination)
    cashInRegister.add(denomination)
  )
  Crafty.e('CashButtons').attr(x: 360).cash(cashInRegister).bind('ButtonClick', (denomination) ->
    cashInRegister.subtract(denomination)
    cashOut.add(denomination)
  )
