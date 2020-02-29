class Camera

    def initialize( game, subject )
        @game = game
        @subject = subject
        @x, @y = subject.x, subject.y
        @zoom = 1
    end

    def can_view?( map_x, map_y, tile )
        x0, x1, y0, y1 = viewport
        ( x0 - tile.width..x1 ).include?( map_x ) &&
            ( y0 - tile.height..y1 ).include?( map_y )
    end

    private 

    def viewport
        x0 = @x - ( @game.window.width / 2 )  / @zoom
        x1 = @x + ( @game.window.width / 2 )  / @zoom
        y0 = @y - ( @game.window.height / 2 ) / @zoom
        y1 = @y + ( @game.window.height / 2 ) / @zoom
        [x0, x1, y0, y1]
    end

end