require 'gosu'

class GameWindow < Gosu::Window 
    def initialize( width=1024, height=768, fullscreen=false )
        super
        self.caption = 'Let\'s Move the Message!'
        @message_x = 10
        @message_y = 10
        @draw_count = 0
        @buttons_down_count = 0
        @message = create_message
    end

    def update
        @message_x -= 1 if button_down?( Gosu::KbLeft ) || button_down?( Gosu::KB_A )
        @message_x += 1 if button_down?( Gosu::KbRight ) || button_down?( Gosu::KB_D )
        @message_y -= 1 if button_down?( Gosu::KbUp ) || button_down?( Gosu::KB_W )
        @message_y += 1 if button_down?( Gosu::KbDown ) || button_down?( Gosu::KB_S )
    end

    def button_down( id )
        close if id == Gosu::KbEscape
        @buttons_down_count +=1
    end

    def button_up( id )
        @buttons_down_count -=1
    end

    def needs_redraw?
        @draw_count == 0 || @buttons_down_count > 0
    end

    def draw 
        @draw_count += 1
        @message = create_message
        @message.draw( @message_x, @message_y, 0 )
    end

    private

    def info
        "[x:#{@message_x};y:#{@message_y};draws:#{@draw_count}]"
    end

    def create_message
        Gosu::Image.from_text( info(), 30, 
        { :font => Gosu.default_font_name,
        :bold => true,
        :italic => true } )
    end

end

window = GameWindow.new 
window.show

