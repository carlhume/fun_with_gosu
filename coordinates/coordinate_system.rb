require 'gosu'

class WorldMap

    attr_reader :on_screen, :off_screen

    def initialize( width, height )
        @on_screen = 0
        @off_screen = 0
        @images = {}

        initialize_map_images( width, height )
    end

    def draw( camera )
        @on_screen = @off_screen = 0
        @images.each do |x, row|
            row.each do |y, value|
                if camera.canView?( x, y, value )
                    value.draw(x, y, 0)
                    @on_screen += 1
                else
                    @off_screen += 1
                end
            end
        end
    end

    private

    def initialize_map_images( width, height ) 
        (0..width).step( 50 ) do |x|
            @images[x] = {}
            (00..height).step( 50 ) do |y|
                image = Gosu::Image.from_text(
                    "#{x}:#{y}", 15,
                    { :font => Gosu.default_font_name }
                )
                @images[x][y] = image
            end
        end
    end
    
end

class Camera

    def initialize( game_window )
        @x = @y = 0
        @zoom = 1
        @window = game_window
    end

    def canView?( x, y, object )
        x0, x1, y0, y1 = viewport
        (x0 - object.width..x1).include?(x) &&
            (y0 - object.height..y1).include?(y)
    end

    def viewport
        x0 = @x - (@window.width / 2)  / @zoom
        x1 = @x + (@window.width / 2)  / @zoom
        y0 = @y - (@window.height / 2) / @zoom
        y1 = @y + (@window.height / 2) / @zoom
        [x0, x1, y0, y1]
    end

end

class GameWindow < Gosu::Window

    WIDTH = 800
    HEIGHT = 600

    def initialize
        super( WIDTH, HEIGHT, false )
        @map = WorldMap.new(2048, 1024)
        @camera = Camera.new( self )
    end

    def button_down( id )
        close if id == Gosu::KbEscape
    end

    def needs_cursor?
        true
    end

    def draw
        @map.draw( @camera )
        draw_count_of_objects_on_and_off_screen
    end

    private 

    def draw_count_of_objects_on_and_off_screen
        info = 'Objects on / off screen: ' <<
            "#{@map.on_screen} / #{@map.off_screen}"
        info_image = Gosu::Image.from_text( 
            info, 30, { :font => Gosu.default_font_name } )
        info_image.draw(10, 10, 1)
    end

end

window = GameWindow.new
window.show