Crafty.scene 'game', ->
  Crafty.background('white')

  # initialization

  ui =
    ticker:         Crafty.e('Ticker').attr(x:20, y: 20)
    customerPrice:  Crafty.e('CustomerPrice').attr(x:20, y:200)
    customerPaid:   Crafty.e('CashButtons').attr(x: 160)
    cashOut:        Crafty.e('CashButtons').attr(x: 260)
    cashInRegister: Crafty.e('CashButtons').attr(x: 360)

  currentCustomer = null
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

  submitRound = ->
    player.get('cashInRegister').merge(currentCustomer.get('paid'))
    plater.set('cashOut', 0)
    generateNewRound()

  generateNewRound = ->
    currentCustomer = new Game.Customer()

    ui.customerPrice.customer(currentCustomer)
    ui.customerPaid.cash(currentCustomer.get('paid'))
    ui.cashOut.cash(player.get('cashOut'))

  # run

  ui.cashInRegister.cash(player.get('cashInRegister'))
  generateNewRound()