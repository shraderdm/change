Crafty.scene "game", ->
  Crafty.background('white')


  ticker = Crafty.e('Ticker').attr(x:20, y: 20)

  round = new Game.Round(player: Game.player)

  cashOut = round.get('cashOut')
  cashInRegister = Game.player.get('cashInRegister')

  Crafty.e('CustomerPrice').attr(x:20, y:200).customer(round.get('customer'))

  Crafty.e('CashButtons').attr(x: 160).cash(round.get('customer').get('paid'))

  Crafty.e('CashButtons').attr(x: 260).cash(cashOut).bind('ButtonClick', (denomination) ->
    cashOut.subtract(denomination)
    cashInRegister.add(denomination)
  )
  Crafty.e('CashButtons').attr(x: 360).cash(cashInRegister).bind('ButtonClick', (denomination) ->
    cashInRegister.subtract(denomination)
    cashOut.add(denomination)
  )
