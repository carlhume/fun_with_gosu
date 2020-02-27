require_relative 'camera'
require_relative 'map'

class PlayScreen < Screen

    def initialize( game )
        super( game )
        @camera = Camera.new
        @map = Map.new( game )
    end

    def update
        @game.window.caption = 
            "Tanks Prototype! [FPS: #{Gosu.fps}]."
    end

    def draw
        @map.draw( @camera )
    end

    def button_down( id )
        super( id )
        @game.show_menu if id == Gosu::KbEscape
    end

end