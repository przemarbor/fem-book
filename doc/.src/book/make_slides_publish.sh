# THIS SCRIPT IS JUST FOR TESTING PUBLISHING PART OF THE make_slides.sh
# AFTER EDITING THE BOTTOM LINES OF THIS SCRIPT, THOSE LINES SHOULD BE
# COPIED DO make_slides.sh

# (Added by MB)

#!/bin/bash
#
# bash ../make_slides.sh slides.do.txt
#
# But this script is normally run from make.sh to make both
# chapter and slides.


ln -rfs ../newcommands_keep.p.tex ./newcommands_keep.p.tex

set -x

dofile=$1
if [ ! -f $dofile ]; then
  echo "No such file: $dofile"
  exit 1
fi
nickname=$2

filename=`echo $dofile | sed 's/\.do\.txt//'`


############
### PREPARE LOCAL PUBLISHING DIRECTORY 
############
##### Prepare publishing directory 
repo=../../../..
dest=${repo}/doc/pub/slides
if [ ! -d $dest ]; then mkdir $dest; fi

# pdf
if [ ! -d $dest/pdf ]; then mkdir $dest/pdf; fi
cp -f ${filename}-beamer.pdf $dest/pdf

# html-like
if [ ! -d $dest/html ]; then mkdir $dest/html; fi
if [ ! -d $dest/html/fig ]; then mkdir $dest/html/fig; fi
if [ ! -d $dest/html/mov ]; then mkdir $dest/html/mov; fi
if [ ! -d $dest/html/figMB ]; then mkdir $dest/html/figMB; fi
cp -rf ../fig/* $dest/html/fig/
cp -rf ../mov/* $dest/html/mov/
cp -rf ../figMB/* $dest/html/figMB/
if [ ! -d $dest/html/pages ]; then mkdir $dest/html/pages; fi

# # html
cp -f ${filename}-1.html $dest/html/pages/

# # html-reveal.js
# if [ ! -d $dest/html/pages/reveal ]; then mkdir $dest/html/reveal; fi
if [ ! -d $dest/html/pages/reveal.js ]; then mkdir $dest/html/pages/reveal.js; fi
cp -rf reveal.js/* $dest/html/pages/reveal.js/
cp -f ${filename}-reveal.html $dest/html/pages/
cp -f ${filename}-reveal-dark.html $dest/html/pages/

# # html-deckjs
if [ ! -d $dest/html/pages/deck.js-latest ]; then mkdir $dest/html/pages/deck.js-latest; fi
cp -rf deck.js-latest/* $dest/html/pages/deck.js-latest/
cp -f ${filename}-deck.html $dest/html/pages/
# ## cp -f ${filename}-deck-dark.html $dest/html/pages/

# add published documents to the repo
cd $dest; git add .; cd -
##### ENDOF: Prepare publishing directory (added by MB)


############
### OR / AND
############

############
### UPLOAD DIRECTLY TO FTP with the use of lftp
############
pwd
# bash ../make_upload2ftp.sh
