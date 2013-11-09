Crafty.scene 'game', ->
  Crafty.background('white')
  soundtrack = new Game.Soundtrack()
  soundtrack.start()

  # initialization

  ui =
    backgroundEls:  Crafty.e('BackgroundElements')
    customerPaid:   Crafty.e('CashButtons').attr(x: 160)
    cashOut:        Crafty.e('CashButtons').attr(x: 260)
    cashInRegister: Crafty.e('CashButtons').attr(x: 360)
    submitButton:   Crafty.e('2D, DOM, Mouse, Color, Text').attr(x: 160, y: 420, w: 260, h: 40).color('#9482BA').textFont(size: '16px/40px').textColor('#FFFFFF').css('text-align': 'center').text('Submit')
    feedbackLabel:  Crafty.e('2D, DOM, Text, Tween').attr(x: 160, y: 470, w: 260, h: 40).textFont(size: '16px').css('text-align': 'center')

    cashTray:       Crafty.e('CashTray')
    cashRegister:   Crafty.e('2D, DOM, Image').image(Game.images.cashRegister).attr(x: 560, y: 50, z: 500)
    receipt:        Crafty.e('Receipt')
    ticker:         Crafty.e('Ticker')

    soundControls:  Crafty.e('SoundControls').attr(x: 895, y: 14).soundtrack(soundtrack)
    foregroundEls:  Crafty.e('ForegroundElements')


  window.ui = ui
  currentCustomer = null
  player = new Game.Player()

  # event bindings


  moveFromTrayToOut = (denomination) ->
    player.get('cashInRegister').subtract(denomination)
    player.get('cashOut').add(denomination)
    Game.sfx.playDenomination(denomination)

  ui.cashTray.bind 'DenominationClick', moveFromTrayToOut
  ui.cashInRegister.bind 'ButtonClick', moveFromTrayToOut


  ui.cashOut.bind('ButtonClick', (denomination) ->
    player.get('cashOut').subtract(denomination)
    player.get('cashInRegister').add(denomination)
    Game.sfx.playDenomination(denomination)
  )

  @bind('KeyDown', (ev) -> submitRound() if ev.key == Crafty.keys[Config.input.submit])
  ui.submitButton.bind('Click', -> submitRound())

  # methods

  submitRound = ->
    difference = Math.abs(currentCustomer.correctChange() - player.get('cashOut').value())
    text = "GREAT!"
    if difference > 0
      text = "You were off by #{difference.toMoneyString()}"
    ui.feedbackLabel.text(text).attr(alpha: 1).tween({alpha: 0}, 60)

    player.get('cashInRegister').merge(currentCustomer.get('paid'))
    player.set('cashOut', new Game.Cash())
    Game.sfx.playRegisterOpen()
    generateNewRound()


  generateNewRound = ->
    currentCustomer = new Game.Customer()
    ui.receipt.customer(currentCustomer).animateUp()

    ui.cashTray.open()
    ui.customerPaid.cash(currentCustomer.get('paid'))
    ui.cashOut.cash(player.get('cashOut'))
    Game.sfx.playRegisterClose()

  # run

  ui.cashInRegister.cash(player.get('cashInRegister'))
  ui.cashTray.cash(player.get('cashInRegister'))
  generateNewRound()