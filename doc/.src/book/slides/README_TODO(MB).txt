* 
Cannot make mako_code.txt to work. So all the variable are defined in newcommands_kep.p.tex

* Cannot success in compiling book.do.txt (i.e. bash make.sh). 
As far as I can tell there is at least something wrong with references 
(because for completely commented out content hyperref package produced an error)
-> TODO: in order to resolve the problem it'd be probably the best to start from the 
completely fresh git-cloned version of the repo.



* 
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
