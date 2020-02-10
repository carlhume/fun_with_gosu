require 'gosu'
require 'gosu_tiled'

MEDIA_DIRECTORY_NAME = 'media'
def find_media_file( filename )
    File.join( File.dirname( File.dirname(__FILE__) ), MEDIA_DIRECTORY_NAME, filename )
end

class GameWindow < Gosu::Window

    WIDTH = 1024
    HEIGHT = 768
    MAP_FILE = find_media_file( "island.json" )
    SPEED = 5

    def initialize
        super( WIDTH, HEIGHT, false )
        @map = Gosu::Tiled.load_json( self, MAP_FILE )
        @x = @y = 0
        @redraw = true
    end

    def button_down( id )
        close if id == Gosu::KbEscape
    end

    def update
        @x = @x - SPEED if button_down?Gosu::KbLeft
        @x = @x + SPEED if button_down?Gosu::KbRight
        @y = @y - SPEED if button_down?Gosu::KbDown
        @y = @y + SPEED if button_down?Gosu::KbUp
        self.caption = "#{Gosu.fps} FPS. Use arrow keys to pan"
    end

    def needs_redraw?
        [Gosu::KbLeft, Gosu::KbRight, Gosu::KbUp, Gosu::KbDown ].each do |b|
            return true if button_down?(b)
        end
        @redraw = true
    end

    def draw
        @redraw = false
        @map.draw( @x, @y )
    end

    def needs_cursor?
        true
    end

end

window = GameWindow.new
window.show