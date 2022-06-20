#!/bin/sh 

ARTIST_ID=$1

curl -o artist_info.xml https://musicbrainz.org/ws/2/artist/${ARTIST_ID}?inc=works

curl -o recordings_info.xml https://musicbrainz.org/ws/2/recording?query=arid:${ARTIST_ID}&limit=1000


echo '<collection>
    <doc href="./files_info/recordings_info.xml" />
    <doc href="./files_info/artist_info.xml" />
</collection>' > collection_dir.xml
