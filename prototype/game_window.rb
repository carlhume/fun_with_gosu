class GameWindow < Gosu::Window

    def initialize
        super( 800, 600, false )
    end

    def update
        @screen.update
    end

    def draw
        @screen.draw
    end

    def needs_cursor?
        true
    end

    def button_down( id )
        @screen.button_down( id )
    end

    def show_screen( screen ) 
        @screen = screen
        @screen.enter
    end
    
end
