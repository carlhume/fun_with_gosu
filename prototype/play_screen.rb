require_relative 'camera'
require_relative 'map'
require_relative 'tank'

class PlayScreen < Screen

    def initialize( game )
        super( game )
        @tank = Tank.new( game )
        @camera = Camera.new( game, @tank )
        @map = Map.new( game )
    end

    def update
        @game.window.caption = 
            "Tanks Prototype! [FPS: #{Gosu.fps}]."
    end

    def draw
        @map.draw( @camera )
        @camera.draw_crosshair
    end

    def button_down( id )
        super( id )
        @game.show_menu if id == Gosu::KbEscape
    end

end