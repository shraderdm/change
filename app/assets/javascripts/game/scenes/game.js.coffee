Crafty.scene 'game', ->
  Crafty.background('white')
  Game.soundtrack.volume()

  # initialization

  ui =
    backgroundEls:  Crafty.e('BackgroundElements')

    feedbackLabel:  Crafty.e('Notification').attr(x: 160, y: 250, w: 260, h: 40)

    customerCash:   Crafty.e('CashPile').attr(x: 20, y: 115).dir('down')
    cashOut:        Crafty.e('CashPile').attr(x: 20, y: 400).dir('up')

    cashRegister:   Crafty.e('CashRegister')
    cashTray:       Crafty.e('CashTray')
    receipt:        Crafty.e('Receipt')
    ticker:         Crafty.e('Ticker')
    score:          Crafty.e('Score').attr(x: 574, y: 7)
    combo:          Crafty.e('Combo').attr(x: 559, y: 24)

    soundControls:  Crafty.e('SoundControls').attr(x: 895, y: 14).soundtrack(Game.soundtrack)
    foregroundEls:  Crafty.e('ForegroundElements')

  window.ui = ui
  currentCustomer = null
  player = new Game.Player()
  score = new Game.Score(ticker:ui.ticker)
  undoStack = []

  # event bindings

  moveFromTrayToOut = (denomination, skipUndo = false) ->
    return if ended
    player.get('cashInRegister').subtract(denomination)
    player.get('cashOut').add(denomination)
    undoStack.push(denomination) unless skipUndo
    Game.sfx.playDenomination(denomination)

  moveBackToTray = (denomination, skipUndo = false) ->
    return if ended
    player.get('cashOut').subtract(denomination)
    player.get('cashInRegister').add(denomination)
    undoStack.push(-1 * denomination) unless skipUndo
    Game.sfx.playDenomination(denomination)

  undo = ->
    top = undoStack.pop()
    if (top)
      denomination = Math.abs(top)
      if (top > 0) then moveBackToTray(denomination, true) else moveFromTrayToOut(denomination, true)

  ui.cashTray.bind 'DenominationClick', moveFromTrayToOut
  ui.cashOut.bind 'DenominationClick', moveBackToTray

  ui.cashTray.bind 'Refill', (denomination) ->
    ui.ticker.subtractTime(2)
    player.get('cashInRegister').add(denomination, 10)

  @bind 'KeyDown', (ev) ->
    return if ended

    if ev.key == Config.input.undo or ev.key == Config.input.alt_undo
      ev.originalEvent.preventDefault()
      ev.originalEvent.stopPropagation()
      undo()
    else if (ev.key == Config.input.submit) or (ev.key == Config.input.otherSubmit)
      submitRound()
    else
      _.each Game.DENOMINATIONS, (d)->
        if ev.key == Config.input.money[d] or ev.key == Config.input.alt_money[d]
          if ev.shiftKey
            moveBackToTray(d)
          else
            moveFromTrayToOut(d)

  ui.cashTray.bind('Submit', -> submitRound() if !ended)

  # methods

  submitRound = ->
    difference = Math.abs(currentCustomer.correctChange() - player.get('cashOut').value())
    text = "GREAT!"
    if difference > 0
      text = "You were off by #{difference.toMoneyString()}"
      ui.feedbackLabel.showNegative(text)
    else
      ui.feedbackLabel.showPositive("GREAT!")
    score.submit(difference)

    player.get('cashInRegister').merge(currentCustomer.get('paid'))
    player.set('cashOut', new Game.Cash())
    generateNewRound()
    Game.sfx.playRegisterOpen()

  generateNewRound = ->
    currentCustomer = new Game.Customer()
    ui.receipt.customer(currentCustomer).animateUp()

    ui.cashTray.open()
    ui.customerCash.cash(currentCustomer.get('paid'))
    ui.cashOut.cash(player.get('cashOut'))
    undoStack = []

  ended = false

  endGame = ->
    ended = true
    newHighscore = score.get('points') > Game.settings.currentHighscore()
    Game.settings.saveHighscore(score.get('points'))
    Game.soundtrack.lowVol()
    Crafty.e('Modal').fadeIn()
    debugger
    Crafty.e('MenuUI').titleText('Game Over').newHighscore(newHighscore)

  # run
  ui.score.scoreModel(score)
  ui.combo.scoreModel(score)
  ui.cashTray.cash(player.get('cashInRegister'))
  ui.ticker.bind('RoundTimeEnded', endGame)
  setTimeout((-> Game.sfx.playRegisterClose()), 200)
  generateNewRound()