class MenuScreen < Screen

    def initialize( game )
        super( game )
        @message = Gosu::Image.from_text( 
            'Tanks Prototype!', 30, { :font => Gosu.default_font_name } )
    end

    def show
        music.play( true )
        music.volume = 1
    end

    def music
        @music ||= @game.repository.find_song( 'menu_music.mp3' )
    end

    def update
        continue_text = @game.has_started ? "C = Continue, " : ""
        @info = Gosu::Image.from_text( 
            "Q = Quit, #{continue_text} N = New Game", 30, { :font => Gosu.default_font_name } ) 
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
        super( id )
        @game.start_new_game if id == Gosu::KbN
        @game.continue_game if id == Gosu::KbC
    end

end