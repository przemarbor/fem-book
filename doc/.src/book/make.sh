#!/bin/bash -x
# Compile the book to LaTeX/PDF.
#
# Usage: make.sh [nospell]
#
# With nospell, spellchecking is skipped.

set -x

name=book
topicname=fem

encoding="--encoding=utf-8"

function system {
  "$@"
  if [ $? -ne 0 ]; then
    echo "make.sh: unsuccessful command $@"
    echo "abort!"
    exit 1
  fi
}

rm -f tmp_* *.dolog

if [ $# -ge 1 ]; then
  spellcheck=$1
else
  spellcheck=spell
fi

if [ "$spellcheck" != 'nospell' ]; then
    cd dotxt
    system doconce spellcheck -d ../.dict4spell.txt *.do.txt
    cd ..
fi

system preprocess -DFORMAT=pdflatex newcommands_keep.p.tex > newcommands_keep.tex
doconce replace 'newcommand{\E}' 'renewcommand{\E}' newcommands_keep.tex
doconce replace 'newcommand{\I}' 'renewcommand{\I}' newcommands_keep.tex

# TASKS: generate book with solutions, also in the html version
# Make pdfnup with two-pages per sheet

CHAPTER=chapter
BOOK=book
APPENDIX=appendix

opt1="CHAPTER=$CHAPTER BOOK=$BOOK APPENDIX=$APPENDIX $encoding FEM_BOOK=True"
opt2="--without_solutions --without_answers"
opt2=
devices="screen paper"

function compile {
    options="$@"
system doconce format pdflatex $name $opt1 --device=$device --exercise_numbering=chapter   --latex_style=Springer_T4 --latex_title_layout=titlepage --latex_list_of_exercises=loe --latex_admon=mdfbox --latex_admon_color=1,1,1 --latex_table_format=left --latex_admon_title_no_period --latex_no_program_footnotelink --latex_copyright=titlepages "--latex_code_style=default:lst[style=blue1_bluegreen]@pypro:lst[style=blue1bar_bluegreen]@dat:lst[style=gray]@sys:vrb[frame=lines,label=\\fbox{{\tiny Terminal}},framesep=2.5mm,framerule=0.7pt,fontsize=\fontsize{9pt}{9pt}]" $options

# Auto edits
# With t4/svmono linewidth has some too large value before \mymainmatter
# is called, so the box width as linewidth+2mm is wrong, it must be
# explicitly set to 120mm.
doconce replace '\setlength{\lstboxwidth}{\linewidth+2mm}' '\setlength{\lstboxwidth}{120mm}' $name.tex  # lst
system doconce replace 'linecolor=black,' 'linecolor=darkblue,' $name.tex
system doconce subst 'frametitlebackgroundcolor=.*?,' 'frametitlebackgroundcolor=blue!5,' $name.tex
doconce replace 'Released under CC Attr' '\\ Released under CC Attr' $name.tex


echo "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
rm -rf $name.aux $name.ind $name.idx $name.bbl $name.toc $name.loe

system pdflatex $name
echo "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
system bibtex $name
system makeindex $name
system pdflatex $name
system pdflatex $name
system makeindex $name
system pdflatex $name
}

# Important: run with solutions first such that the .aux file
# for the book, referred to by other documents, uses the .aux
# file corresponding to a version without solutions.

# With solutions, password protected
compile --device=screen

newname=${topicname}-book-4screen-sol
password="f!e!m"
pdftk $name.pdf output $newname.pdf owner_pw foo user_pw $password
cp $name.pdf $newname.pdf 
cp $name.pdf ${name}-sol.pdf # good to have a copy without password

compile --device=screen --without_solutions --without_answers
newname=${topicname}-book-4screen
cp $name.pdf $newname.pdf

#--latex_index_in_margin
compile --device=paper --without_solutions --without_answers
newname=${topicname}-book-4print
cp $name.pdf $newname.pdf
pdfnup --frame true --outfile ${newname}-2up.pdf $newname.pdf
cp $name.aux ${newname}.aux-final

# Report typical problems with the book (too long lines,
# undefined labels, etc.). Here we report lines that are more than 10pt
# too long.
doconce latex_problems $name.log 10

# Check grammar in MS Word:
# doconce spellcheck tmp_mako__book.do.txt
# load tmp_stripped_book.do.txt into Word

# Publish
repo=../../..
dest=${repo}/doc/pub/book
if [ ! -d $dest ]; then mkdir $dest; fi
if [ ! -d $dest/pdf ]; then mkdir $dest/pdf; fi
cp ${topicname}-book*.pdf $dest/pdf
cd $dest; git add .; cd -

# What about slides? They are published by make_slides.sh!
# The FDM book shows how to publish them chapter-wise.
