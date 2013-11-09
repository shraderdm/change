Crafty.scene 'game', ->
  Crafty.background('white')
  soundtrack = new Game.Soundtrack()
  soundtrack.start()

  # initialization

  ui =
    backgroundEls:  Crafty.e('BackgroundElements')

    submitButton:   Crafty.e('2D, DOM, Mouse, Color, Text').attr(x: 160, y: 280, w: 260, h: 40).color('#9482BA').textFont(size: '16px/40px').textColor('#FFFFFF').css('text-align': 'center').text('Submit')
    feedbackLabel:  Crafty.e('2D, DOM, Text, Tween').attr(x: 160, y: 250, w: 260, h: 40).textFont(size: '16px').css('text-align': 'center')

    customerCash:   Crafty.e('CashPile').attr(x: 20, y: 115).dir('down')
    cashOut:        Crafty.e('CashPile').attr(x: 20, y: 450).dir('up')

    cashRegister:   Crafty.e('2D, DOM, Image').image(Game.images.cashRegister).attr(x: 560, y: 50, z: 500)
    cashTray:       Crafty.e('CashTray')
    receipt:        Crafty.e('Receipt')
    ticker:         Crafty.e('Ticker')
    score:          Crafty.e('Score').attr(x: 20, y: 20)

    soundControls:  Crafty.e('SoundControls').attr(x: 895, y: 14).soundtrack(soundtrack)
    foregroundEls:  Crafty.e('ForegroundElements')

  window.ui = ui
  currentCustomer = null
  ui.score.ticker(ui.ticker)
  player = new Game.Player()

  # event bindings

  moveFromTrayToOut = (denomination) ->
    player.get('cashInRegister').subtract(denomination)
    player.get('cashOut').add(denomination)
    Game.sfx.playDenomination(denomination)

  moveBackToTray = (denomination) ->
    player.get('cashInRegister').add(denomination)
    player.get('cashOut').subtract(denomination)
    Game.sfx.playDenomination(denomination)

  ui.cashTray.bind 'DenominationClick', moveFromTrayToOut
  ui.cashOut.bind 'DenominationClick', moveBackToTray

  @bind('KeyDown', (ev) -> submitRound() if ev.key == Crafty.keys[Config.input.submit])
  ui.submitButton.bind('Click', -> submitRound())

  # methods

  submitRound = ->
    difference = Math.abs(currentCustomer.correctChange() - player.get('cashOut').value())
    text = "GREAT!"
    if difference > 0
      text = "You were off by #{difference.toMoneyString()}"
    ui.score.submit(difference)
    ui.feedbackLabel.text(text).attr(alpha: 1).tween({alpha: 0}, 60)

    player.get('cashInRegister').merge(currentCustomer.get('paid'))
    player.set('cashOut', new Game.Cash())
    Game.sfx.playRegisterOpen()
    generateNewRound()

  generateNewRound = ->
    currentCustomer = new Game.Customer()
    ui.receipt.customer(currentCustomer).animateUp()

    ui.cashTray.open()
    ui.customerCash.cash(currentCustomer.get('paid'))
    ui.cashOut.cash(player.get('cashOut'))
    Game.sfx.playRegisterClose()

  # run
  ui.cashTray.cash(player.get('cashInRegister'))
  generateNewRound()