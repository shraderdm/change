Crafty.c 'Ticker',

  init: ->
    @requires('2D, DOM, Text, Delay')
    .textColor('black')
    .attr({w: 174, h: 46, x: 752, y: 107, z: 500})
    .textFont(size: '39px')
    .css('text-align': 'center')
    .delay(@_tick, 1000, Infinity)

    @_remainingSeconds = Config.game.time

    @_updateTicker()

  addTime: (time) ->
    @_remainingSeconds += time
    @_updateTicker()

  subtractTime: (time) ->
    @_remainingSeconds -= time
    @_remainingSeconds = Math.max(0, @_remainingSeconds)
    @_updateTicker()

  _tick: ->
    return if @_didRoundEnd()
    @_remainingSeconds -= 1
    @_updateTicker()
    @trigger('RoundTimeEnded') if @_didRoundEnd()

  _updateTicker: ->
    @text(@_remainingSeconds.toMMSS())
    @trigger('RoundTimeChanged')

  _didRoundEnd: ->
    @_remainingSeconds == 0