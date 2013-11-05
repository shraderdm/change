#= require ./denomination

# Holds an integer money amount divided into concrete denominations from Game.DENOMINATIONS
class Game.Amount extends Backbone.Model

  # Set up a new amount object
  # options:
  #   default: amount for each multiplier by default
  #   1,5,50...: specific amounts for each multiplier
  constructor: (@options = {}) ->
    super()
    denominations = {}
    for denomination in Game.DENOMINATIONS
      denominations[denomination] = @options[denomination] || @options.default || 0
    @set('denominations', denominations)


  # calculate the value for all the money
  value: ->
    v = 0
    for denomination,multiplier of @get('denominations')
      v += denomination * multiplier
    v

  valueString: (withSymbol = true) ->
    s = (@value()/100).toFixed(2)
    s = "$" + s if withSymbol
    s

  # value for specific denomination
  valueFor: (denomination) ->
    @amountOf(denomination) * denomination

  # get the amount of a specific denomination
  amountOf: (denomination) ->
    @get('denominations')[denomination]

  # Add amounts for a specific denomination
  add: (denomination, value = 1) ->
    throw "Unsupported denomination #{denomination}" if not denomination in Game.DENOMINATIONS
    @get('denominations')[denomination] +=  value
    @_triggerChange()

  # Remove amounts from a denomination
  subtract: (denomination, value = 1) ->
    @get('denominations')[denomination] -= value
    @_triggerChange()

  _triggerChange: ->
    @trigger('change')