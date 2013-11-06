Crafty.c 'CashButtons',
  init: ->
    @requires('2D').attr(x: 240, y: 0)
    @_buttons = []

  cash: (cash) ->
    @_cash = cash
    y = @_y
    amountLabel = Crafty.e('2D, DOM, Text').attr(x: @_x, y: 0, w: 40).text(@_cash.valueString()).textFont(size: '20px/2').css('text-align': 'center')
    y += 40
    @_cash.on('change', => amountLabel.text(@_cash.valueString()))

    _.each Game.DENOMINATIONS, (denomination) =>
      button = Crafty.e('DenominationButton').attr(x: @_x, y: y).denomination(denomination).amount(@_cash.amountOf(denomination))
      @_cash.on("change:#{denomination}", => button.amount(@_cash.amountOf(denomination)))
      @_buttons.push(button)
      button.bind('Click', => @trigger('ButtonClick', denomination))
      y += 40

    @