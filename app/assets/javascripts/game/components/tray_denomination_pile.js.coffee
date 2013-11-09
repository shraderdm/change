Crafty.c 'TrayDenominationPile',
  randomizers:
    bill:
      rotation: 10
      x: 5
      y: 5
    coin:
      rotation: 2
      x: 10
      y: 10

  _amount: 10

  init: ->
    _.bindAll(@, '_createDenomination')
    @requires('2D, DOM, Mouse')
     .attr(z: 299, w: 82)
    @denominations = []

  denomination: (denomination) ->
    if Game.isBill(denomination)
      @attr(h: 129)
    else
      @attr(h: 80)
    @_denomination = denomination
    _.times @_amount, @_createDenomination
    @

  amount: (amount) ->
    @_amount = amount
    _.times amount - @denominations.length, => # create more than the 10 initial denomination
      @_createDenomination().move('e', @_x).move('s', @_y)
    @_show(amount)
    @

  _show: (x) ->
    _.each @denominations, (el, idx) ->
      if idx < x
        el.visible = true
      else
        el.visible = false

  _createDenomination: ->
    item = Crafty.e('Denomination').denomination(@_denomination)
    item
    if Game.isBill(@_denomination)
      item.scale(0.4).origin('center').attr(rotation: 90 + @_random('rotation'), x: -10 + @_random('x'), y: 40 + @_random('y'))
    else
      item.scale(0.6).attr(rotation: @_random('rotation'), x: 20 + @_random('x'), y: 20 + @_random('y'))
      if @_denomination == 50
        item.move('nw', 10)
    @attach(item)
    @denominations.push(item)
    item

  _random: (attr)->
    randomize = if Game.isBill(@_denomination) then @randomizers.bill else @randomizers.coin
    _.random(-1 * randomize[attr], randomize[attr])