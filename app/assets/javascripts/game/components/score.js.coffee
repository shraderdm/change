Crafty.c 'Score',

  init: ->
    @requires('2D, DOM, Text')
    .textFont(size: '30px')
    .css('text-align': 'left')

    @_score = 0
    @_combo = 1

    @bind('Remove', => @_score.off())

  scoreModel: (score) ->
    @_score = score
    @_score.on('change:points', @_update, @)
    @_update()
    @

  _update :->
    @text(@_score.get('points'))
