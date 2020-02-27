require 'gosu_texture_packer'
require 'perlin_noise'

class Map

    MAP_WIDTH = 100
    MAP_HEIGHT = 100
    TILE_SIZE = 128

    def initialize( game )
        @game = game
        load_tiles
        @map = generate_map 
    end

    def draw( camera ) 
        @map.each do | x, row |
            row.each do | y, value |
                tile = @map[x][y]
                map_x = x * TILE_SIZE
                map_y = y * TILE_SIZE
                if camera.can_view?( map_x, map_y, tile )
                    tile.draw( map_x, map_y, 0 )
                end
            end
        end
    end

    private

    def load_tiles
        ground_file = @game.repository.find_media_file( 'ground.png' )
        tiles = Gosu::Image.load_tiles( @game.window, @game.repository.find_media_file( 'ground.png' ), 128, 128, true )
        @sand = tiles[0]
        @grass = tiles[8]
        @water = Gosu::Image.new( @game.repository.find_media_file( 'water.png' ), tileable: true )
    end

    def generate_map
        noises = Perlin::Noise.new(2)
        contrast = Perlin::Curve.contrast( Perlin::Curve::CUBIC, 2 )
        map = {}
        MAP_WIDTH.times do |x|
            map[x] = {}
            MAP_HEIGHT.times do |y|
                noise = noises[x * 0.1, y * 0.1]
                noise = contrast.call( noise )
                map[x][y] = choose_tile( noise )
            end
        end
        map
    end

    def choose_tile( value )
        case value
        when 0.0..0.3
            @water
        when 0.3..0.45
            @sand
        else
            @grass
        end
    end

end