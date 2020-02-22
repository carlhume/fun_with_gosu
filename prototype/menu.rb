class Menu

    def initialize( game_window, media_repository )
        @window = game_window
        @repository = media_repository
        @message = Gosu::Image.from_text( 
            'Tanks Prototype!', 30, { :font => Gosu.default_font_name } )
    end

    def enter
        music.play( true )
        music.volume = 1
    end

    def music
        @music ||= @repository.find_song( 'menu_music.mp3' )
    end

    def update
        @info = Gosu::Image.from_text( 
            "Q = Quit, N = New Game", 30, { :font => Gosu.default_font_name } ) 
    end

    def draw
        @message.draw( 
            @window.width / 2 - @message.width / 2,
            @window.height / 2 - @message.height / 2, 
            10
        )
        @info.draw( 
            @window.width / 2 - @info.width / 2,
            @window.height / 2 - @info.height / 2 + (@message.height + @info.height), 
            10
        )
    end

    def button_down( id )
    end

end