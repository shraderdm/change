#= require crafty
#= require_self
#= require ./config
#= require_directory ./objects
#= require_directory ./components/generic
#= require_directory ./components
#= require_directory ./models
#= require_directory ./scenes

window.Game = {}

$(document).ready ->
  Crafty.init(Config.window.width, Config.window.height, document.getElementById('game'))
  Crafty.scene('loading')
