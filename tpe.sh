#!/bin/sh 

ARTIST_ID=$1

curl -o artist_info.xml https://musicbrainz.org/ws/2/artist/${ARTIST_ID}?inc=works

curl -o recordings_info.xml https://musicbrainz.org/ws/2/recording?query=arid:${ARTIST_ID}&limit=1000





