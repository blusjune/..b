#!/bin/bash

./.bdx.0100.n.star.doe.pkg.install.sh

source .env/bin/activate;
export _DOE_ROW=10000;
export _DOE_COL=10000;
export _DOE_ITER=20; 
python .blib.python.prof.mem.py
