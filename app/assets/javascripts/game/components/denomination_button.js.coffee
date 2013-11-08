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

  denomination: (value) ->
    @_denomination = value
    @color(@_colors[value])
    @requires('coin') unless @_isDollar()
    @_updateText()

  amount: (value) ->
    @_amount = value
    @alpha = value / 2 + 0.1
    @_updateText()

  _updateText: ->
    denominationString = if @_isDollar() then "#{@_denomination/100}$" else "#{@_denomination}¢"
    @text("#{denominationString} x #{@_amount}")
    @

  _isDollar: ->
    Game.isBill(@_denomination)

  _colors:
    1: '#bf6042'
    5: '#b5b6b5'
    10: '#9EA89E'
    25: '#9EA8A8'
    50: '#A8A89E'
    100: '#85bb65'
    500: '#9BD678'
    1000: '#7DB03A'
)