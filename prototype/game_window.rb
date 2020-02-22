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

end
