#!/bin/bash

if [ $# -gt 1 ]; then
    executions=$1
    shift
    threads=$1
    shift
else
    echo "execute.sh nb-executions nb-threads"
    exit
fi

#Types of thread bind on tinySTM
binds=(LINUX_DEFAULT COMPACT SCATTER ROUNDROBIN)
outputfile=(linux compact scatter roundrobin)

#To show total of aborts and commits
export STM_STATS=1;\

for i in 0 1 2 3; do

  cd ../tinySTM
  make clean
  make BIND_THREAD=-DBIND_THREAD=${binds[$i]}
  cd ../stamp
  ./compile.sh

  export STM_BIND_THREAD=${binds[$i]};\
  for j in `seq 1 $executions`; do
    ./stamp-test.sh output/${outputfile}_$threads.txt stm real ${threads}
  done

done

./stamp-eagerMap.sh $executions $threads
