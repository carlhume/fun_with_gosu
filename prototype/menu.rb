class Menu

    def initialize( game_window )
        @window = game_window
        @message = Gosu::Image.from_text( 
            'Tanks Prototype!', 100, { :font => Gosu.default_font_name } )
    end

    def draw
        @message.draw( 
            @window.width / 2 - @message.width / 2,
            @window.height / 2 - @message.height / 2, 
            10
        )
    end

end