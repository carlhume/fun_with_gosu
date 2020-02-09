require 'gosu'
require 'gosu_texture_packer'

MEDIA_DIRECTORY_NAME = 'media'
def find_media_file( filename )
    File.join( File.dirname( File.dirname(__FILE__) ), MEDIA_DIRECTORY_NAME, filename )
end

class GameWindow < Gosu::Window

    WIDTH = 1024
    HEIGHT = 768
    TILE_SIZE = 128
    
    def initialize
        super( WIDTH, HEIGHT, false )
        self.caption = 'Random Map'
        @tileset = Gosu::TexturePacker.load_json( find_media_file( 'ground.json' ), :precise )
        @redraw = true
    end

    def button_down( id )
        close if id == Gosu::KbEscape
        @redraw = true if id == Gosu::KbSpace
    end

    def needs_redraw?
        @redraw
    end

    def draw
        @redraw = false
        (0..WIDTH / TILE_SIZE).each do |x|
            (0..HEIGHT / TILE_SIZE).each do |y|
                @tileset.frame( @tileset.frame_list.sample ).draw( 
                    x * (TILE_SIZE),
                    y * (TILE_SIZE),
                    0 )
            end
        end
    end

    def needs_cursor?
        true
    end

end

window = GameWindow.new
window.show