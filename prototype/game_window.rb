class GameWindow < Gosu::Window

    attr_accessor :state
    
    def initialize
        super( 800, 600, false )
    end

    def draw
        @state.draw
    end

    def needs_cursor?
        true
    end

end
