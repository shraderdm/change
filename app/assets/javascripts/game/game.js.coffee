Crafty.init(Config.window.width, Config.window.height, document.getElementById('game'))
Crafty.background('white')

Crafty.c('coin'
  init: ->
    @requires('2D, DOM, Color, Text')
      .color('#bf6042')
      .attr(w: 50, h: 50)
      .text('1¢')
      .textFont(size: '25px/2')
      .unselectable()
      .css('text-align': 'center')
)
Crafty.e('coin').attr(x: 0, y:0)

denomonations = [
  {id: 'penny', value: 1, type: 'coin', color: '#bf6042'}
  {id: 'nickel', value: 5, type: 'coin'}
  {id: 'dime', value: 10, type: 'coin'}
  {id: 'quarter', value: 25, type: 'coin'}
  {id: 'half-dollar', value: 50, type: 'coin'}
  {id: 'dollar', value: 100, type: 'bill'}
  {id: 'five-dollars', value: 500, type: 'bill'}
  {id: 'ten-dollars', value: 1000, type: 'bill'}
  {id: 'twenty-dollars', value: 2000, type: 'bill'}
]