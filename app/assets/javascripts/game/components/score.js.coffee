Crafty.c 'Score',

  TIME_PENALTY: 1
  TIME_BONUS: 1
  SCORE_MULTIPLIER: 100

  init: ->
    @requires('2D, DOM, Text')
    .textFont(size: '39px')
    .css('text-align': 'center')

    @_score = 0
    @_combo = 1

    @_update()

  ticker: (ticker) ->
    @_ticker = ticker
    @

  submit: (diff) ->
    if diff == 0
      @_score += @_combo * @SCORE_MULTIPLIER
      @_combo += 1
      @_ticker.addTime(@TIME_BONUS)
    else
      console.log(diff)
      @_combo = 1
      @_ticker.subtractTime(Math.ceil(Math.log(diff) * @TIME_PENALTY))

    @_update()
    @

  _update :->
    @text(@_score)
