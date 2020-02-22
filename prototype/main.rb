require 'gosu'
require_relative 'game_window'
require_relative 'menu'

@window = GameWindow.new
@window.screen = Menu.new( @window )
@window.show