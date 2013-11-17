Crafty.c 'Notification',

  colors:
    positive: '#2A7311'
    negative: '#B31919'

  init: ->
    @requires('2D, DOM, Text, Tween')
      .attr(x: 160, y: 250, w: 260, h: 40, z: 100)
      .textFont(size: '32px')
      .css('text-align': 'center')
    @_yBase = null
    @

  showPositive: (text)->
    @textColor(@colors.positive)
    .showAnimated(text)

  showNegative: (text)->
    @textColor(@colors.negative)
    .showAnimated(text)

  showAnimated: (text)->
    @_yBase ||= @_y
    @text(text).attr(alpha: 1, y: @_yBase).tween({
      alpha: 0,
      y: @_yBase - 50
    }, 70)
