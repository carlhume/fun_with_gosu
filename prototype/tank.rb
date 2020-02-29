class Tank

    attr_accessor :x, :y,

    def initialize
        puts( ">> cnh >> Wrong initialize called - why is this method needed???" )
    end

    def initialize( game )
        @x = 1
        @y = 1
    end

end
