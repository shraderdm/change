Crafty.c 'Combo',

  init: ->
    @requires('2D, DOM, Text')
    .textFont(size: '12px')
    .textColor('#ffffff')
    .css('text-align': 'left')
    .bind('Remove', => @_score.off())

  scoreModel: (score) ->
    @_score = score
    @_score.on('change:combo', @_update, @)
    @_score.on('success', => setTimeout((=> Game.sfx.playCombo(@_score.get('combo'))), 2))
    @_update()
    @

  _update: ->
    @text("x#{@_score.get('combo')}")


