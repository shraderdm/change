Crafty.c 'CashButtons',
  init: ->
    @requires('2D').attr(x: 240, y: 120)
    @_buttons = {}

    @

  cash: (cash) ->
    @_cash.off() if @_cash?
    @_cash = cash
    @_bY = @_y

    _.each Game.DENOMINATIONS, (denomination) =>
      button = @_createOrInitializeButton(denomination)
      button.amount(@_cash.amountOf(denomination))
      @_cash.on("change:#{denomination}", => button.amount(@_cash.amountOf(denomination)))

    @

  _createOrInitializeButton: (denomination) ->
    return @_buttons[denomination] if @_buttons[denomination]
    button = Crafty.e('DenominationButton').attr(x: @_x, y: @_bY).denomination(denomination)
    button.bind('Click', => @trigger('ButtonClick', denomination))
    @_buttons[denomination] = button
    @_bY += 40
    button