Crafty.c('DenominationButton',
  _denomination: null
  _amount: null

  init: ->
    @requires('2D, DOM, Color, Mouse, Text')
    .attr(w: 60, h: 30)
    .color('green')
    .textColor('#FFFFFF')
    .textFont(size: '13px/30px')
    .css('text-align': 'center')
    .unselectable()
    .bind('MouseDown', -> @alpha = 0.8)
    .bind('MouseUp', -> @alpha = 1)

  denomination: (value) ->
    @_denomination = value
    @_updateText()


  amount: (value) ->
    @_amount = value
    @_updateText()

  _updateText: ->
    denominationString = if @_denomination >= 100 then "#{@_denomination/100}$" else "#{@_denomination}¢"
    @text("#{denominationString} x #{@_amount}")
    @
)