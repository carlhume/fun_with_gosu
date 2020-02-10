require 'gosu'

MEDIA_DIRECTORY_NAME = 'media'
def find_media_file( filename )
    File.join( File.dirname( File.dirname(__FILE__) ), MEDIA_DIRECTORY_NAME, filename )
end

class Explosion

    FRAME_DELAY = 100  #ms
    SPRINT_FILE = find_media_file( 'explosion_atlas_170.png' )
    EXPLOSION_SOUND_FILE = find_media_file( 'explosion.mp3' )

    def self.load_animation( window )
        Gosu::Image.load_tiles( window, SPRINT_FILE, 170, 170, false ) 
    end

    def self.load_sound()
        Gosu::Sample.new( EXPLOSION_SOUND_FILE );
    end

    def initialize( animation, sound, x, y )
        @animation = animation
        sound.play
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

    BACKGROUND = find_media_file( 'country_field.png' )
    SONG_FILE = find_media_file( 'menu_music.mp3')

    def initialize( width=1024, height=768, fullscreen=false )
        super
        self.caption = 'Time to Explode!'
        @background = Gosu::Image.new( BACKGROUND, false )
        @music = Gosu::Song.new( SONG_FILE )
        @music.volume = 0.5
        @music.play( true )
        @animation = Explosion.load_animation( self )
        @sound = Explosion.load_sound()
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
            @explosions.push( Explosion.new( @animation, @sound, mouse_x, mouse_y ) )
        end
    end

end

window = GameWindow.new
window.show

