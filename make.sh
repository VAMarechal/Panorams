#!/bin/bash
outFile="build/index.html"
echo '<html><head>' > $outFile 
echo '    <title>Pano rams</title>' >> $outFile
echo '</head><body align="center">' >> $outFile
 
for file in `find img/ -type f -name "*.jpg" | sort -gr |  cut -d'/' -f2`
do
     echo '<H3>'${file}'</H3>' ;
     echo '<iframe width="600" height="400" allowfullscreen style="border-style:none;" src="lib/pannellum.htm#panorama=../img/'${file}'&autoLoad=true"></iframe>' ;
     # echo '<p>' ;
done  >> $outFile
 
echo '</body></html>' >> $outFile
