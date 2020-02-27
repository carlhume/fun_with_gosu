require 'gosu'
require_relative 'screen'
require_relative 'game_window'
require_relative 'menu_screen'
require_relative 'media_repository'
require_relative 'play_screen'

class Game

    attr_accessor :window, :repository

    def initialize
        @window = GameWindow.new
        @repository = MediaRepository.new
        @menu_screen = MenuScreen.new( self )
        @window.show_screen( @menu_screen )
        @window.show
    end

    def start_new_game
        @play_screen = PlayScreen.new( self )
        @window.show_screen( @play_screen )
    end

end

@game = Game.new