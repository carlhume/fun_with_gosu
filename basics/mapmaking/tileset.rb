require 'json'
require 'gosu'

class Tileset
    def initialize( window, json )
        @json = JSON.parse( File.read( json ) )
        image_file = File.join( File.dirname( json ), @json['meta']['image'] )
        @main_image = Gosu::Image.new( @window, image_file, true )
    end

    def frame( name )
        named_frame = @json['frames'][name]['frame']
        @main_image.subimage( named_frame['x'], named_frame['y'], named_frame['w'], named_frame['h'] )
    end
end
