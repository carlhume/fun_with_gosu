require 'gosu'

class Explosion

    FRAME_DELAY = 100  #ms
    SPRITE = File.join( File.dirname( File.dirname(__FILE__) ), 'media', 'explosion_atlas_170.png' )

    def self.load_animation(window)
        Gosu::Image.load_tiles( window, SPRITE, 170, 170, false ) 
    end

    def initialize( animation, x, y )
        @animation = animation
        @explosion_x, @explosion_y = x, y
        @current_frame = 0
    end

    def update
        @current_frame += 1 if frame_expired?
    end

    def done?
        @done ||= @current_frame == @animation.size
    end

    def draw
        return if done?
        image = current_frame
        image.draw( 
            @explosion_x - image.width / 2,
            @explosion_y - image.height / 2,
            0
        )
    end
    
    private

    def current_frame
        @animation[@current_frame % @animation.size]
    end

    def frame_expired?
        now = Gosu.milliseconds
        @last_frame ||= now
        if ( now - @last_frame ) > FRAME_DELAY  
            @last_frame = now
        end
    end

end    

class GameWindow < Gosu::Window

    BACKGROUND = File.join( File.dirname( File.dirname(__FILE__) ), 'media', 'country_field.png' )

    def initialize( width=1024, height=768, fullscreen=false )
        super
        self.caption = 'Time to Explode!'
        @background = Gosu::Image.new( BACKGROUND, false )
        @animation = Explosion.load_animation( self )
        @explosions = []
    end

    def update
        @explosions.reject!( &:done? )
        @explosions.map( &:update )
    end    

    def needs_redraw?
        !@scene_ready || @explosions.any?
    end

    def draw
        @scene_ready ||= true
        @background.draw( 0, 0, 0 )
        @explosions.map( &:draw )
    end

    def needs_cursor?
        true
    end

    def button_down( id )
        close if id == Gosu::KbEscape
        if id == Gosu::MsLeft
            @explosions.push( Explosion.new( @animation, mouse_x, mouse_y ) )
        end
    end

end

window = GameWindow.new
window.show

