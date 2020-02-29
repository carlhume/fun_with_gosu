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

    def update
        update_camera_position
        update_camera_zoom
        puts( self )
    end

    def zoom_in
        @zoom += zoom_delta
    end

    def zoom_out
        @zoom -= zoom_delta
    end

    def zoom_in_slowly
        @zoom += zoom_delta / 3
    end

    def zoom_out_slowly
        @zoom -= zoom_delta / 3
    end

    def to_s
        "FPS: #{Gosu.fps}. " <<
        "#{@x}:#{@y} @ #{'%.2f' % @zoom}. " <<
        'WASD to move, arrows to zoom.'
    end

    private 

    def update_camera_position
        @x += @subject.speed if @x < @subject.x - @game.window.width / 4
        @x -= @subject.speed if @x < @subject.x + @game.window.width / 4
        @y += @subject.speed if @y < @subject.y - @game.window.height / 4
        @y -= @subject.speed if @y < @subject.y + @game.window.height / 4
    end

    def update_camera_zoom
        if @game.window.button_down?( Gosu::KbUp )
            zoom_out unless @zoom < 0.7
        elsif @game.window.button_down?( Gosu::KbDown )
            zoom_in unless @zoom > 10
        else
            target_zoom = @subject.speed > 1.1 ? 0.85 : 1.0
            puts( @zoom )
            if @zoom <= ( target_zoom - 0.01 )
                zoom_in_slowly
            elsif @zoom >= ( target_zoom + 0.01 )
                zoom_out_slowly
            end
        end
    end
    
    def viewport
        x0 = @x - ( @game.window.width / 2 )  / @zoom
        x1 = @x + ( @game.window.width / 2 )  / @zoom
        y0 = @y - ( @game.window.height / 2 ) / @zoom
        y1 = @y + ( @game.window.height / 2 ) / @zoom
        [x0, x1, y0, y1]
    end

    def zoom_delta
        @zoom > 0 ? 0.01 : 1.0
    end

end