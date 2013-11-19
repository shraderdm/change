class Game.Soundtrack extends Backbone.Model
  TRACK_DELAY: 10

  defaults:
    songs: [ #each row should be changed to array containing mp3, ogg, wav for each file...
      '08-BlueSkiesAndRedShoes.mp3'
      'mix_n_match.mp3'
      'Soft-Chip.mp3'
    ]
    isPlaying: false
    directory: '/assets/'
    currentSong: null
    muted: false

  initialize: ->
    @set('count', @get('songs').length)
    @_chooseRandomSong() unless @get('currentSong')?
    @_loadTrack()

  start: ->
    @play()
    @_startLoading()

  next: ->
    Crafty.audio.stop(@_trackName())
    @playNextRandomTrack()

  playNextRandomTrack: ->
    @_chooseRandomSong()
    @play()

  play: ->
    console.log('playing', @_trackName(), @_trackPaths())
    Crafty.audio.play(@_trackName(), 1, 0.3)
    Crafty.audio.sounds[@_trackName()].obj.addEventListener "ended", _.once =>
      setTimeout((=> @playNextRandomTrack()), @TRACK_DELAY)
    @set('isPlaying': true)

  toggleMute: ->
    Crafty.audio.toggleMute()
    @set('muted', Crafty.audio.muted)

  _chooseRandomSong: ->
    @set('currentSong', _.sample(@_allOtherTrackIdxs()))

  _allOtherTrackIdxs: ->
    _.without(_.range(@get('count')), @get('currentSong'))

  _trackName: (id = @get('currentSong')) ->
    "track#{id}"

  _trackPaths: (id = @get('currentSong')) ->
    src = _.flatten([@get('songs')[id]])
    _.map(src, (filename) => "#{@get('directory')}#{filename}")

  _loadTrack: (id = @get('currentSong')) ->
    Crafty.audio.add(@_trackName(id), @_trackPaths(id))

  _startLoading: ->
    ids = @_allOtherTrackIdxs()
    _.each ids, (id) =>
      @_loadTrack(id)