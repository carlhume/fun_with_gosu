require 'gosu'
require_relative 'game_window'
require_relative 'menu'
require_relative 'media_repository'

class Game

    def initialize
        @window = GameWindow.new
        @repository = MediaRepository.new
        @window.screen = Menu.new( @window, @repository )
        @window.screen.enter
        @window.show
    end

end

@game = Game.new