class Game.Settings

  toggleMute: (value) ->
    store.set('mute', value)

  isSoundMuted: ->
    value = store.get('mute')
    if value == undefined
      store.set('mute', false)
      false
    else
      value

  hasSavedHighscore: ->
    value = store.get('highscore')
    value != undefined

  saveHighscore: (score) ->
    value = store.get('highscore')
    if value == undefined
      store.set('highscore', score)
    else
      store.set('highscore', score) if score > value


  didSeeTutorial: ->
    value = store.get('tutorial')
    if value == undefined
      false
    else
      value

  sawTutorial: ->
    store.set('tutorial', true)