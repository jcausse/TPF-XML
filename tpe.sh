#!/bin/sh 

error_string=""
error=0

# validate parameters amount
if [ $# -ne 1 ]
then 
    error_string="<error>Invalid amount of parameters: only one param artist id permitted.</error>"
    error=1
fi

# assignation of parameter
ARTIST_ID=$1
VALUE= grep "<artist arid=\"$ARTIST_ID\"/>" "artists_list.xml"
if [ VALUE == 1 ] # 1 -> not found a match
then 
    error_string=$error_string"<error>Artist ID not found.</error>"
    error=1
fi

if [ error==1 ]
then
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><artist_data xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"artist_data.xsd\">$error_string</artist_data>" > "artist_data.xml"
    echo "Script executed with errors."

else
    
    CURL_ERROR="<error>Could not connect with API https://musicbrainz.org. Not reacheable.</error>"

    echo "Getting artist_info.xml..."
    curl -o artist_info_aux.xml https://musicbrainz.org/ws/2/artist/${ARTIST_ID}?inc=works
    if [ $? -ne 0 ]
    then    
        error_string=$CURL_ERROR
    else
        echo "Getting recordings_info.xml..."
        curl -o recordings_info_aux.xml https://musicbrainz.org/ws/2/recording?query=arid:${ARTIST_ID}&limit=1000
        if [ $? -ne 0 ]
        then
            error_string=$CURL_ERROR
        else
            # at this point both files are downloaded succesfully
            # the namespace is removed
            sleep 1
            sed 's/<metadata xmlns="http:\/\/musicbrainz\.org\/ns\/mmd-2\.0#">//g;s/<\/metadata>//g' artist_info_aux.xml > artist_info.xml
            sleep 1
            sed 's/<metadata.*xmlns:ns2="http:\/\/musicbrainz\.org\/ns\/ext#-2\.0">//g;s/<\/metadata>//g;s/ns2:score="100"//g' recordings_info_aux.xml > recordings_info.xml
        
            # XQuery execution
            java net.sf.saxon.Query extract_data.xq -o:artist_data.xml

            # Deletion of auxiliar files
            rm artist_info_aux.xml
            rm recordings_info_aux.xml

            echo "Finished execution."

        fi
    fi
fi


# Execution of XSL Transform and generation of .adoc page
java net.sf.saxon.Transform -s:artist_data.xml -xsl:generate_doc.xsl -o:artist_page.adoc
