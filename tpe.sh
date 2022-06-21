#!/bin/sh 

ARTIST_ID=$1

curl -o artist_info_aux.xml https://musicbrainz.org/ws/2/artist/${ARTIST_ID}?inc=works

curl -o recordings_info_aux.xml https://musicbrainz.org/ws/2/recording?query=arid:${ARTIST_ID}&limit=1000

sleep 1

# quizas es mejor dejar el metadata y sacar solo los atributos
sed 's/<metadata xmlns="http:\/\/musicbrainz\.org\/ns\/mmd-2\.0#">//g;s/<\/metadata>//g' artist_info_aux.xml > artist_info.xml

sleep 1

sed 's/<metadata.*xmlns:ns2="http:\/\/musicbrainz\.org\/ns\/ext#-2\.0">//g;s/<\/metadata>//g;s/ns2:score="100"//g' recordings_info_aux.xml > recordings_info.xml

# no funcionan los remove ...
rm -rf artist_info_trash
rm -rf recordings_info_trash
