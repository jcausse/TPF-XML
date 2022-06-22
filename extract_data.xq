<artist_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation= "artist_data.xsd">

    let $artist := doc("artist_info.xml")/artist
    
    <artist>
        <name>data($artist/name)</name>
        <disambiguation>data($artist/disambiguation)</disambiguation>
        <type>data($artist/@type)</type>
        <area>
            <name>data($artist/area/name)</name>
            <origin>data($artist/begin-area/name)</origin>
        </area>
        <life-span>
            <begin>data($artist/life-span/begin)</begin>
            <end>data($artist/life-span/end)</end>
            <ended>data($artist/life-span/ended)</ended>
        </life-span>
        
        <recordings>
        {
            for $recording in doc("reordings_info.xml")/recording-list/recording
            order by $recording/title
            return
            <recording>
                <title>data($recording/title)</title>
                <length>data($recording/length)</length>
                <first-release-date>data($recording/first-release-date)</first-release-date>
                for $release in $recording/release
                return
                <release>
                    <title>data($release/title)</title>
                    <date>data($release/date)</date>
                    <country>data($release/country)</country>
                    <type>data($release/release-group/primary-type)</type>
                    <subtype>data($release/release-group/secondary-type-list/secondary-type)</subtype>
                    <track-number>data($release/medium-list/track-count)</track-number>
                </release>
            
            </recording>
        }
        </recordings>
    </artist>

</artist_data>