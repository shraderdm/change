class Game.Round extends Backbone.Model

  initialize: ->
    _.bindAll(@, '_checkVictory')
    @set('customer', new Game.Customer())
    @set('cashOut', new Game.Cash())
    @listenTo(@get('cashOut'), 'change', @_checkVictory)

  destroy: ->
    @stopListening()

  _checkVictory: ->
    @trigger('EndedRoundSuccessfully') if @get('customer').correctChange() == @get('cashOut').value()