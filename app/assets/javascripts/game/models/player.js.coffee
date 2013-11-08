
class Game.Player extends Backbone.Model

  DEFAULT_AMOUNT_OF_DENOMINATION = 10
  
  initialize: ->
    @reset()

  reset: ->
    @set('cashInRegister', new Game.Cash(default: DEFAULT_AMOUNT_OF_DENOMINATION))
