class Menu

    def initialize( game_window, media_repository )
        @window = game_window
        @repository = media_repository
        @message = Gosu::Image.from_text( 
            'Tanks Prototype!', 100, { :font => Gosu.default_font_name } )
    end

    def enter
        music.play( true )
        music.volume = 1
    end

    def music
        @music ||= @repository.find_song( 'menu_music.mp3' )
    end


    def draw
        @message.draw( 
            @window.width / 2 - @message.width / 2,
            @window.height / 2 - @message.height / 2, 
            10
        )
    end

end