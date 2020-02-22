class MediaRepository

    def initialize
        @loaded_files = Hash.new
    end

    MEDIA_DIRECTORY_NAME = 'prototype/media'
    def find_media_file( file_name )
        File.join( File.dirname( File.dirname(__FILE__) ), MEDIA_DIRECTORY_NAME, file_name )
    end

    def find_song( song_name )
        @loaded_files[song_name] ||=Gosu::Song.new( find_media_file( song_name ) )
        @loaded_files[song_name]
    end

end