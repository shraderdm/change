Crafty.c "Walkthrough",
  steps: [
    {title: 'Welcome to the CHANG€', text: 'CHANG€ is an intense game about the extreme life of supermarket cashiers'}
    {highlight:{x: 800, y: 100}, title: 'Time is money', text: 'The objective in CHANG€ is to get as many points in 60 seconds'}
    {highlight:{x: 615, y: 125}, title: 'The Customer is always right...', text: 'Each round a new customer will come up and a receipt will be printed with the total he has to pay'}
    {highlight:{x: 360, y: 100}, title: '... but annoying', text: 'He will place a certain amount of cash in front of you'}
    {highlight:{x: 590, y: 420}, title: 'Money Money Money', text: 'You need to put the correct change from your register by clicking on the different denominations'}
    {highlight:{x: 260, y: 400}, title: 'It\'s OK to be wrong', text: 'If you took out too much of a denomination, just click on it to take it back to the cash register'}
    {highlight:{x: 725, y: 500}, title: 'Ding!', text: 'Once you think you have the correct amount set push the cash tray close'}
    {highlight:{x: 560, y: 0}, title: 'Dong!', text: 'You will receive the most points if you get the exact amount correct'}
    {highlight:{x: 765, y: 290}, title: 'Mo Money, Mo Problems', text: 'If you ever run out of money, you can request a refill which will cost you 2 seconds'}
    {highlight:{x: -60, y: -60}, title: 'Keyboard Fu', text: 'To play even faster you can use the keyboard.
        <ul>
          <li><strong>1-7</strong>to take money out of the tray</li>
          <li><strong>SHIFT 1-7</strong>to take money back to the tray</li>
          <li><strong>SPACE</strong>to push the tray close</li>
          <li><strong>BACKSPACE</strong>to undo</li>
        </ul>'}
  ]

  init: ->
    @requires('2D, DOM, HTML')
     .attr(w: 320, z: 1002, x: 330, y: 200)
      .setter('title', @title)
      .setter('text', @text)
      .setter('highlight', @highlight)
    @_highlight = Crafty.e('2D, DOM, Highlight').attr(w: 60, h: 60, x: -60, y: -60, z: 1001)
    @_currentStep = -1
    @step()
    @

  title: (title)->
    @_title = title
    @_refresh()

  text: (text) ->
    @_text = text
    @_refresh()

  highlight: (highlight)->
    @_highlight.attr(highlight)

  _refresh: ->
    @replace("<div class='title'>#{@_title}</div><div class='text'>#{@_text}</div>")

  step: ->
    @_currentStep += 1
    if @_currentStep >= @steps.length
      @trigger('Ended')
      return
    @attr(@steps[@_currentStep])

