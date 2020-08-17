#!/bin/sh

#1 million tree size (-i)
tree_size=1000000

#execute 50 millions operations per threads (-d)
#operations=50000000
operations=1000000


cd ../../tinySTM
make clean
make INSTRUMENT=-DINSTRUMENT=METHOD1 BIND_THREAD=-DBIND_THREAD=COMPACT
cd ../stamp/redblacktree
make -f Makefile clean
make -f Makefile

for j in 8 16 32 64; do
   duration=$((operations * j)) 
   exec ./redblacktree -i $tree_size -d $duration -u 90 -n $j | tee -a redblacktree_instrument_${j}.txt
done


