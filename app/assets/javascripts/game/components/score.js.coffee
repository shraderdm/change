Crafty.c 'Score',

  init: ->
    @requires('2D, DOM, Text')
    .textFont(size: '30px')
    .css('text-align': 'left')

    @_score = 0
    @_combo = 1

  scoreModel: (score) ->
    @_score = score
    @_update()
    @

  _update :->
    @text(@_score.get('points'))
