Crafty.c 'CustomerPrice',

  init: ->
    @requires('2D, DOM, Text')
    .textFont(size: '30px')

  customer: (customer) ->
    @text(customer.get('price').toMoneyString())
    @