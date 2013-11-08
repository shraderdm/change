Crafty.scene "game", ->
  Crafty.background('white')

  # initialization

  ui =
    ticker:         Crafty.e('Ticker').attr(x:20, y: 20)
    customerPrice:  Crafty.e('CustomerPrice').attr(x:20, y:200)
    customerPaid:   Crafty.e('CashButtons').attr(x: 160)
    cashOut:        Crafty.e('CashButtons').attr(x: 260)
    cashInRegister: Crafty.e('CashButtons').attr(x: 360)

  currentRound = null

  # event bindings

  ui.cashOut.bind('ButtonClick', (denomination) ->
    currentRound.get('cashOut').subtract(denomination)
    Game.player.get('cashInRegister').add(denomination)
  )

  ui.cashInRegister.bind('ButtonClick', (denomination) ->
    Game.player.get('cashInRegister').subtract(denomination)
    currentRound.get('cashOut').add(denomination)
  )

  # methods

  generateNewRound = ->
    currentRound = new Game.Round(player: Game.player)
    ui.customerPrice.customer(currentRound.get('customer'))
    ui.customerPaid.cash(currentRound.get('customer').get('paid'))

  # run

  ui.cashOut.cash(new Game.Cash()) # init with empty cash.
  ui.cashInRegister.cash(Game.player.get('cashInRegister'))
  generateNewRound()