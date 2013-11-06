class Game.Customer extends Backbone.Model

  initialize: ->
    @set('price', @_randomizePrice())
    @set('paid', @_randomizePaid())

  _randomizePrice: ->
    _.pick([499, 1230, 1100])

  _randomizePaid: ->
    paid = new Game.Cash(1000: 5)
    # Stupidly hard computation
    paid

  correctChange: ->
    @get('paid').value() - @get('price')