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
  player = new Game.Player()

  # event bindings

  ui.cashOut.bind('ButtonClick', (denomination) ->
    currentRound.get('cashOut').subtract(denomination)
    player.get('cashInRegister').add(denomination)
  )

  ui.cashInRegister.bind('ButtonClick', (denomination) ->
    player.get('cashInRegister').subtract(denomination)
    currentRound.get('cashOut').add(denomination)
  )

  # methods

  endRound = ->
    currentRound.off('EndedRoundSuccessfully', endRound)
    player.get('cashInRegister').merge(currentRound.get('customer').get('paid'))
    generateNewRound()

  generateNewRound = ->
    currentRound = new Game.Round(player: player)
    ui.customerPrice.customer(currentRound.get('customer'))
    ui.customerPaid.cash(currentRound.get('customer').get('paid'))
    ui.cashOut.cash(currentRound.get('cashOut'))
    currentRound.on('EndedRoundSuccessfully', endRound)

  # run

  ui.cashInRegister.cash(player.get('cashInRegister'))
  generateNewRound()