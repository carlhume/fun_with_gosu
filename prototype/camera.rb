class Camera

    def initialize( game, subject )
        @game = game
        @subject = subject
        @zoom = 1
    end

    def can_view?( map_x, map_y, tile )
        x0, x1, y0, y1 = viewport
        ( x0 - tile.width..x1 ).include?( map_x ) &&
            ( y0 - tile.height..y1 ).include?( map_y )
    end

    private 
    
    def viewport
        x0 = @subject.x - ( @game.window.width / 2 )  / @zoom
        x1 = @subject.x + ( @game.window.width / 2 )  / @zoom
        y0 = @subject.y - ( @game.window.height / 2 ) / @zoom
        y1 = @subject.y + ( @game.window.height / 2 ) / @zoom
        [x0, x1, y0, y1]
    end

end