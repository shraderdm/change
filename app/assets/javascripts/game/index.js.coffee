#= require crafty
#= require_self
#= require ./config
#= require_directory ./models
#= require_directory ./scenes

window.Game = {}

$(document).ready ->
  Crafty.init(Config.window.width, Config.window.height, document.getElementById('game'))
  Crafty.scene('game')