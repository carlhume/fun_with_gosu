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
        draw_crosshair
    end

    def button_down( id )
        super( id )
        @game.show_menu if id == Gosu::KbEscape
    end

    private

    def draw_crosshair
        x = @game.window.mouse_x
        y = @game.window.mouse_y
        @game.window.draw_line(
            x - 10, y, Gosu::Color::RED,
            x + 10, y, Gosu::Color::RED, 100 )
        @game.window.draw_line(
            x, y - 10, Gosu::Color::RED,
            x, y + 10, Gosu::Color::RED, 100 )
    end
    
end