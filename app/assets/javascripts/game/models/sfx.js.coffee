class SoundEffects extends Backbone.Model
  defaults:
    bills:
      keyFormat: 'bill-{0}'
      fileFormat: '/assets/bills/bill-{0}.mp3'
      count: 8
    coins:
      keyFormat: 'coin-{0}'
      fileFormat: '/assets/coins/coin-{0}.mp3'
      count: 7

    combos:
      keyFormat: 'combo{0}'
      fileFormat: '/assets/combos/combo{0}.mp3'
      count: 9

    registerClose:
      keyFormat: 'register-close'
      fileFormat: '/assets/register/close-print.mp3'
      count: 1

    registerOpen:
      keyFormat: 'register-open'
      fileFormat: '/assets/register/open.mp3'
      count: 1

    comboBroken:
      keyFormat: 'combo-broken'
      fileFormat: '/assets/combos/combo-broken.mp3'
      count: 1

    gameover:
      keyFormat: 'gameover'
      fileFormat: '/assets/gameover.mp3'
      count: 1

  initialize: ->
    _.each @attributes, (value, key) =>
      @_loadFiles(value)

  playDenomination: (denomination)->
    if Game.isBill(denomination)
      @playBill()
    else
      @playCoin()

  playBill: ->
    @_play(@get('bills'))

  playCoin: ->
    @_play(@get('coins'))

  playComboBroken: ->
    @_play(@get('comboBroken'))

  playRegisterClose: ->
    @_play(@get('registerClose'))

  playRegisterOpen: ->
    @_play(@get('registerOpen'))

  playUnacceptable: ->
#    @_play(@get('unacceptable'))

  playGameover: ->
    @_play(@get('gameover'))

  playCombo: (combo) ->
    combo = Math.min(9, combo - 1)
    key = @get('combos').keyFormat.format(combo)
    Crafty.audio.play(key, 1)

  _play: (options) ->
    randomIdx = _.random(options.count)
    key = options.keyFormat.format(randomIdx)
    Crafty.audio.play(key, 1)

  _loadFiles: (options) ->
    _.times options.count, (idx) ->
      Crafty.audio.add(options.keyFormat.format(idx), options.fileFormat.format(idx))


Game.sfx = new SoundEffects()