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

    def draw_crosshair
        x = @game.window.mouse_x
        y = @game.window.mouse_y
        @game.window.draw_line(
            x - 10, y, Gosu::Color::RED,
            x + 10, y, Gosu::Color::RED, 100 )
        @game.window.draw_line(
            x, y - 10, Gosu::Color::RED,
            x, y + 10, Gosu::Color::RED, 100 )
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