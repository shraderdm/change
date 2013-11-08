class Game.Customer extends Backbone.Model

  initialize: ->
    @set('price', @_randomizePrice())
    @set('paid', @_randomizePaid())

  _randomizePrice: ->
    _.sample([499, 1230, 1105, 199, 599, 250, 769, 1940, 156, 79,50,99,24, 299,249,229])

  _randomizePaid: ->
    paid = new Game.Cash()
    target = @get('price')
    while target > 0
      cash = @_randomChunk(target)
      target -= cash.value()
      paid.merge(cash)
    paid

  _randomChunk: (target)->
    random = Math.random()
    if target > 1000
      return new Game.Cash(1000: 1)
    if random <= 0.5
      @_smallerDenomRounded(target)
    else
      @_oneLargeDenomination(target)

  _smallerDenomRounded: (target)->
    roundDenominations = [50, 100, 500]
    roundTo = _.sample(roundDenominations)
    target = Math.ceil(target/roundTo) * roundTo
    cash = new Game.Cash()
    _.each roundDenominations.reverse(), (denomination)->
      amount = Math.floor(target / denomination)
      cash.add(denomination, amount)
      target = target % denomination
    cash

  _oneLargeDenomination: (target)->
    bigDenominations = _.filter(Game.DENOMINATIONS, (d)-> d > target)
    d = _.sample(bigDenominations)
    cash = new Game.Cash()
    cash.add(d)
    cash


  correctChange: ->
    @get('paid').value() - @get('price')