require 'gosu'

class GameWindow < Gosu::Window 
    def initialize( width=1024, height=768, fullscreen=false )
        super
        self.caption = 'Hello'
        @message = Gosu::Image.from_text( 'Hello World!', 100, 
                    { :font => Gosu.default_font_name,
                      :bold => true,
                      :italic => true } )
    end

    def draw
        @message.draw( self.width / 2 - @message.width / 2, 
                       self.height / 2 - @message.height / 2, 10 )
    end
end

window = GameWindow.new
window.show
