In order to have slides compiled you need to link/copy 
newcommands_keep.p.tex 
from .src/book/ to .src/book/slides/ directory

    cd .src/book/slides/
    ln -rs ../newcommands_keep.p.tex newcommands_keep.p.tex
    # or
    cd .src/book/
    ln -rs newcommands_keep.p.tex ./slides/
    # or
    ln -rs newcommands_keep.p.tex ./slides/newcommands_keep.p.tex



The same thing should be done with make_code.txt file,
which stores some variables like {$fem_src} {$fem_doc} that link to 
some external content. 

The bad thing is that these links are OUTDATED. 
They should be updated.

Probably pointing them to local directories should be sufficient to 
have things working.

So far it is done by deleting all mako variables and 
manual changes in the code.
