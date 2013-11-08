Crafty.scene "game", ->
  Crafty.background('white')


  ui =
    ticker:         Crafty.e('Ticker').attr(x:20, y: 20)
    customerPrice:  Crafty.e('CustomerPrice').attr(x:20, y:200)
    customerPaid:   Crafty.e('CashButtons').attr(x: 160)
    cashOut:        Crafty.e('CashButtons').attr(x: 260)
    cashInRegister: Crafty.e('CashButtons').attr(x: 360)

  round = new Game.Round(player: Game.player)
  cashOut = round.get('cashOut')
  cashInRegister = Game.player.get('cashInRegister')

  ui.customerPrice.customer(round.get('customer'))
  ui.customerPaid.cash(round.get('customer').get('paid'))

  ui.cashOut.cash(cashOut).bind('ButtonClick', (denomination) ->
    cashOut.subtract(denomination)
    cashInRegister.add(denomination)
  )

  ui.cashInRegister.cash(cashInRegister).bind('ButtonClick', (denomination) ->
    cashInRegister.subtract(denomination)
    cashOut.add(denomination)
  )
