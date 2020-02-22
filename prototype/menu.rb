class Menu

    MEDIA_DIRECTORY_NAME = 'prototype/media'
    def find_media_file( filename )
        File.join( File.dirname( File.dirname(__FILE__) ), MEDIA_DIRECTORY_NAME, filename )
    end

    def initialize( game_window )
        @window = game_window
        @message = Gosu::Image.from_text( 
            'Tanks Prototype!', 100, { :font => Gosu.default_font_name } )
    end

    def enter
        music.play( true )
        music.volume = 1
    end

    def music
        @music ||= Gosu::Song.new( find_media_file( 'menu_music.mp3' ) )
    end


    def draw
        @message.draw( 
            @window.width / 2 - @message.width / 2,
            @window.height / 2 - @message.height / 2, 
            10
        )
    end

end