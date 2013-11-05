Crafty.init(Config.window.width, Config.window.height, document.getElementById('game'))
Crafty.background('white')

Crafty.c('MoneyButton',
  _denomination: null

  init: ->
    @requires('2D, DOM, Color, Mouse, Text')
    .attr(w: 30, h: 30)
    .textColor('#FFFFFF')
    .textFont(size: '13px/30px')
    .css('text-align': 'center')
    .unselectable()
    .bind('MouseDown', -> @alpha = 0.8)
    .bind('MouseUp', -> @alpha = 1)

  amount: (value) ->
    @_denomination = value
    printValue = Math.abs(value)
    if (printValue >= 100)
      @text("#{printValue/100}$")
    else
      @text("#{printValue}¢")
    @

  add: ->
    @color('green')
    .bind('Click', ->
      Game.player.get('cashInRegister').add(@_denomination)
    )
  sub: ->
    @color('red')
    .bind('Click', ->
      Game.player.get('cashInRegister').subtract(@_denomination)
    )
)


cashInRegister = Game.player.get('cashInRegister')
amountLabel = Crafty.e('2D, DOM, Text').attr(x: 240, y: 0).text(cashInRegister.valueString()).textFont(size: '20px')
y = 30
labels = {}

for denomination in Game.DENOMINATIONS
  Crafty.e('MoneyButton').amount(denomination).add().attr(x: 240, y: y)
  label = Crafty.e('2D, DOM, Text').attr(x: 270, y: y, w: 20).textFont(size: '10px/30px').css('text-align': 'center').text(cashInRegister.amountOf(denomination))
  labels[denomination] = label
  Crafty.e('MoneyButton').amount(denomination).sub().attr(x: 290, y: y)
  y += 40

cashInRegister.on 'change', ->
  amountLabel.text(@valueString())
  for denomination in Game.DENOMINATIONS
    labels[denomination].text(@amountOf(denomination))
