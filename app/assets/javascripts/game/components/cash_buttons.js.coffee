Crafty.c 'CashButtons',
  init: ->
    @requires('2D').attr(x: 240, y: 20)
    @_buttons = []

  cash: (cash) ->
    @_cash = cash
    y = @_y

    _.each Game.DENOMINATIONS, (denomination) =>
      button = Crafty.e('DenominationButton').attr(x: @_x, y: y).denomination(denomination).amount(@_cash.amountOf(denomination))
      @_cash.on("change:#{denomination}", => button.amount(@_cash.amountOf(denomination)))
      @_buttons.push(button)
      button.bind('Click', => @trigger('ButtonClick', denomination))
      y += 40

    @