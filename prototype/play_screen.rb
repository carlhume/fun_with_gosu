class PlayScreen < Screen

    def button_down( id )
        super( id )
        @game.show_menu if id == Gosu::KbEscape
    end

end