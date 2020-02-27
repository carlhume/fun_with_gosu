class MenuScreen < Screen

    def initialize( game )
        @game = game
        @message = Gosu::Image.from_text( 
            'Tanks Prototype!', 30, { :font => Gosu.default_font_name } )
    end

    def enter
        music.play( true )
        music.volume = 1
    end

    def music
        @music ||= @game.repository.find_song( 'menu_music.mp3' )
    end

    def update
        @info = Gosu::Image.from_text( 
            "Q = Quit, N = New Game", 30, { :font => Gosu.default_font_name } ) 
    end

    def draw
        @message.draw( 
            @game.window.width / 2 - @message.width / 2,
            @game.window.height / 2 - @message.height / 2, 
            10
        )
        @info.draw( 
            @game.window.width / 2 - @info.width / 2,
            @game.window.height / 2 - @info.height / 2 + (@message.height + @info.height), 
            10
        )
    end

    def button_down( id )
        @game.window.close if id == Gosu::KbQ
        @game.start_new_game if id == Gosu::KbN
    end

end