#!/bin/bash
export LD_LIBRARY_PATH=/home/dp.pasqualin/topomatch/lib:$LD_LIBRARY_PATH

for dir in \
    bayes \
    genome \
    intruder \
    kmeans \
    labyrinth \
    ssca2 \
    vacation \
    yada
do

cd ${dir}
make -f Makefile.stm clean
make -f Makefile.stm
cd ..

done



for dir in \
    hashmap \
    redblacktree 
do

cd ${dir}
make -f Makefile clean
make -f Makefile
cd ..

done


