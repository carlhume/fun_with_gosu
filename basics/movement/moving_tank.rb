require 'gosu'
require 'gosu_texture_packer'
require 'gosu_tiled'

UP_BUTTON = Gosu::KbW
DOWN_BUTTON = Gosu::KbS
LEFT_BUTTON = Gosu::KbA
RIGHT_BUTTON = Gosu::KbD

MEDIA_DIRECTORY_NAME = 'media'
def find_media_file( filename )
    File.join( File.dirname( File.dirname(__FILE__) ), MEDIA_DIRECTORY_NAME, filename )
end

class Tank 

    def initialize( window, bodyPNG, shadowPNG, gunPNG )
        @window = window
        @body = bodyPNG
        @shadow = shadowPNG
        @gun = gunPNG        

        @x = window.width / 2
        @y = window.height / 2
        @body_angle = 0.0
        @gun_angle = 0.0
    end
    
    def update
        update_gun_angle()
        update_body_angle()
    end

    def draw
        @shadow.draw_rot( @x - 1, @y - 1, 0, @body_angle )
        @body.draw_rot( @x, @y, 1, @body_angle )
        @gun.draw_rot( @x, @y, 2, @gun_angle )
    end

    private

    def update_gun_angle
        atan = Math.atan2( 320 - @window.mouse_x, 240 - @window.mouse_y ) 
        @gun_angle = -atan * 180 / Math::PI
    end

    def update_body_angle
        previous_angle = @body_angle
        if @window.button_down?( UP_BUTTON )
            angle = 0.0
            angle -= 45.0 if @window.button_down?( LEFT_BUTTON )
            angle += 45.0 if @window.button_down?( RIGHT_BUTTON )
        elsif @window.button_down?( DOWN_BUTTON )
            angle = 180.0
            angle += 45.0 if @window.button_down?( LEFT_BUTTON )
            angle -= 45.0 if @window.button_down?( RIGHT_BUTTON )
        elsif @window.button_down?( LEFT_BUTTON )
            angle = 90.0
            angle += 45.0 if @window.button_down?( UP_BUTTON )
            angle -= 45.0 if @window.button_down?( DOWN_BUTTON )
        elsif @window.button_down?( RIGHT_BUTTON )
            angle = 270.0
            angle -= 45.0 if @window.button_down?( UP_BUTTON )
            angle += 45.0 if @window.button_down?( DOWN_BUTTON )
        end
        @body_angle = angle || previous_angle
    end

end

class GameWindow < Gosu::Window

    WIDTH = 640
    HEIGHT = 480
    MAP_FILE = find_media_file( "island.json" )
    UNITS_FILE = find_media_file( "ground_units.json" )
    SPEED = 5

    def initialize
        super( WIDTH, HEIGHT, false )
        @map = Gosu::Tiled.load_json( self, MAP_FILE )
        @units = Gosu::TexturePacker.load_json( UNITS_FILE, :precise )
        @tank = Tank.new( self,
            @units.frame('tank1_body.png'),
            @units.frame('tank1_body_shadow.png'),
            @units.frame('tank1_dualgun.png'),
        )
        @x = @y = 0
        @first_render = true
        @buttons_down = 0
    end

    def button_down( id )
        close if id == Gosu::KbEscape
        @buttons_down += 1
    end

    def button_up( id )
        @buttons_down -= 1
    end

    def update
        @x = @x - SPEED if button_down?LEFT_BUTTON
        @x = @x + SPEED if button_down?RIGHT_BUTTON
        @y = @y - SPEED if button_down?UP_BUTTON
        @y = @y + SPEED if button_down?DOWN_BUTTON
        @tank.update
        self.caption = "#{Gosu.fps} FPS. Use WASD to move tank"
    end

    def needs_cursor?
        true
    end

    def draw
        @first_render = false
        @map.draw( @x, @y )
        @tank.draw()
    end

end

window = GameWindow.new
window.show