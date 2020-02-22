class GameWindow < Gosu::Window

    attr_accessor :screen

    def initialize
        super( 800, 600, false )
    end

    def draw
        @screen.draw
    end

    def needs_cursor?
        true
    end

    def button_down( id )
        close if id == Gosu::KbQ
        @screen.button_down( id )
    end

end
