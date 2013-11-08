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
    player.get('cashOut').subtract(denomination)
    player.get('cashInRegister').add(denomination)
  )

  ui.cashInRegister.bind('ButtonClick', (denomination) ->
    player.get('cashInRegister').subtract(denomination)
    player.get('cashOut').add(denomination)
  )

  @bind('KeyDown', (ev) -> submitRound() if ev.key == Crafty.keys[Config.input.submit])

  # methods

  submitRound = ->
    player.get('cashInRegister').merge(currentCustomer.get('paid'))
    player.set('cashOut', new Game.Cash())
    generateNewRound()

  generateNewRound = ->
    currentCustomer = new Game.Customer()
    ui.customerPrice.customer(currentCustomer)
    ui.customerPaid.cash(currentCustomer.get('paid'))
    ui.cashOut.cash(player.get('cashOut'))

  # run

  ui.cashInRegister.cash(player.get('cashInRegister'))
  generateNewRound()