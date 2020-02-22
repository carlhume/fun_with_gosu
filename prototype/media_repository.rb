class MediaRepository

    MEDIA_DIRECTORY_NAME = 'prototype/media'
    def find_media_file( filename )
        File.join( File.dirname( File.dirname(__FILE__) ), MEDIA_DIRECTORY_NAME, filename )
    end

    def find_song( song_name )
        Gosu::Song.new( find_media_file( song_name ) )
    end

end