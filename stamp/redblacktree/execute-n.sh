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

#1 million tree size (-i)
tree_size=1000000

#execute 50 millions operations per threads (-d)
operations=50000000

#Types of thread bind on tinySTM
binds=(LINUX_DEFAULT COMPACT SCATTER ROUNDROBIN)
outputfile=(linux compact scatter roundrobin)

#To show total of aborts and commits
export STM_STATS=1;\

for i in 0 1 2 3; do

	cd ../../tinySTM
	make clean
	make BIND_THREAD=-DBIND_THREAD=${binds[$i]}
	cd ../stamp/redblacktree
	make -f Makefile clean
	make -f Makefile

  export STM_BIND_THREAD=${binds[$i]};\
  for j in `seq 1 $executions`; do
     duration=$((operations * i)) 
  	 exec ./redblacktree -i $tree_size -d $duration -n $threads >> redblacktree_${threads}.txt
  done

done

#./stamp-eagerMap.sh $executions $threads
