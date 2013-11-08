Crafty.c 'FontAwesomeButton',
  _icon: null

  init: ->
    @requires('2D, DOM, Text, Mouse, fa')
    .attr(w: 20, h: 20)
    .textFont(size: '20px', family: 'FontAwesome')

  icon: (icon)->
    @removeComponent(@_icon).addComponent(icon)
    @_icon = icon
    @

Crafty.c 'VolumeButton',
  _states:
    off: 'fa-volume-off'
    on: 'fa-volume-up'

  init: ->
    @requires('FontAwesomeButton')
    .bind('Click', => @trigger('ToggleMute'))
    .icon(@_states.on)

  updateMuteIcon: (muted) ->
    if muted
      @icon(@_states.off)
    else
      @icon(@_states.on)


Crafty.c 'SoundControls',
  _soundtrack: null

  init: ->
    _.bindAll(@, '_updateIconMuted', '_toggleMute', '_skip')
    @requires('2D')

  soundtrack: (soundtrack) ->
    @_soundtrack = soundtrack
    soundtrack.on('change:muted', @_updateIconMuted)
    @_buildUI()
    @

  _buildUI: ->
    @_volumeButton = Crafty.e('VolumeButton').attr(y: @_y, x: @_x)
    @_volumeButton.bind('ToggleMute', @_toggleMute)
    @_nextButton = Crafty.e('FontAwesomeButton').attr(y: @_y , x: @_x + 30).icon('fa-forward').bind('Click', @_skip)

  _toggleMute: ->
    console.log('mute')
    @_soundtrack.toggleMute()

  _updateIconMuted: ->
    @_volumeButton.updateMuteIcon(@_soundtrack.get('muted'))

  _skip: ->
    @_soundtrack.next()