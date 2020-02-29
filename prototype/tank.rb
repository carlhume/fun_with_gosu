class Tank

    attr_accessor :x, :y,

    def initialize
        puts( ">> cnh >> Wrong initialize called - why is this method needed???" )
    end

    def initialize( game )
        @game = game    
        @x = 1
        @y = 1
    end

    def speed        
        @speed ||= 1.0
        if moving?
            @speed += 0.03 if @speed < 5
        else
            @speed = 1.0
        end
        @speed
    end
    
    def moving?
        any_button_down?( Gosu::KbA, Gosu::KbD, Gosu::KbW, Gosu::KbS )
    end

    private 

    def any_button_down?( *buttons )
        buttons.each do | button |
            return true if @game.window.button_down?( button )
        end
        false
    end

end
