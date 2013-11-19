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
