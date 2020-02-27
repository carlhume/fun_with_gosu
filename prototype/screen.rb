class Screen

    def initialize( game )
        @game = game
    end

    def show
    end

    def update
    end

    def draw
    end

    def button_down( id )
    end

    def button_down( id )
        @game.window.close if id == Gosu::KbQ
    end

end