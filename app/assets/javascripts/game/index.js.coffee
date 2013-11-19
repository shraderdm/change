#= require crafty
#= require_self
#= require ./settings
#= require ./config
#= require_directory ./assets
#= require_directory ./components/generic
#= require_directory ./components
#= require_directory ./models
#= require_directory ./scenes

window.Game = {}

$(document).ready ->
  Game.settings = new Game.Settings()
  Crafty.init(Config.window.width, Config.window.height, document.getElementById('game'))
  Crafty.scene('loading')
