#!/bin/bash

if [ $# -gt 0 ]; then
    executions=$1
    shift
else
    echo "run.sh nb-executions"
    exit
fi

#export LD_LIBRARY_PATH=/home/dp.pasqualin/topomatch/lib:$LD_LIBRARY_PATH

#To show total of aborts and commits
export STM_STATS=1;\

#export TOPOLOGY_HWLOC_XML=/home/dp.pasqualin/tekoha.xml;\

#Memory sample
#SAMPLE_INTERVAL AND MAPPING_INTERVAL should be defined in tinySTM Makefile
#export SAMPLE_INTERVAL=100;\
#export MAPPING_INTERVAL=10000;\
#export MAPPING_INTERVAL=50000;\


cd ../tinySTM
make clean
make INSTRUMENT=-DINSTRUMENT=METHOD1 BIND_THREAD=-DBIND_THREAD=LINUX_DEFAULT
cd ../stamp
./compile.sh

for i in 8 16 32 64; do

   export STM_BIND_THREAD=ONLINE;\ #Anything that you want. Just to help to differentiate the output
   for j in `seq 1 $executions`; do
     ./stamp-test.sh online_mapping.txt stm real ${i}
   done
   
done
