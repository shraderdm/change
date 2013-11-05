DEFAULT_AMOUNT_OF_DENOMINATION = 10

class Player extends Backbone.Model
  initialize: ->
    @reset()

  reset: ->
    @set('cashInRegister', new Game.Amount(default: DEFAULT_AMOUNT_OF_DENOMINATION))

Game.player = new Player()
