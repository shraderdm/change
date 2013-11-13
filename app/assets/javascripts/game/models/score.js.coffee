class Game.Score extends Backbone.Model

  defaults:
    points: 0
    combo: 1
    ticker: null

  SCORE_MULTIPLIER: 100
  TIME_BONUS_PER_SUCCESS: 2
  TIME_PENALTY_MULTIPLIER_PER_FAILURE: 1

  submit: (diff) ->
    if diff == 0
      @submitSuccess()
    else
     @submitFailure(diff)

  submitSuccess: ->
    @set('points', @get('points') + @get('combo') * @SCORE_MULTIPLIER)
    @set('combo', @get('combo') + 1)
    @get('ticker').addTime(@TIME_BONUS_PER_SUCCESS)

  submitFailure: (diff) ->
    @set('combo', @defaults.combo)
    @get('ticker').subtractTime(Math.ceil(@diffFailureTransform(diff) * @TIME_PENALTY))

  diffFailureTransform: (diff) ->
    Math.log(diff)




