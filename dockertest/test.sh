#!/bin/bash

#start some testing containers
for ((i=0; i<2; i++)); do docker run --privileged=true --rm lrulock bash -c " sleep 20000" & done

#do testing evn setup 
for i in `docker ps | sed '1 d' | awk '{print $1 }'` ;do docker exec --privileged=true -it $i bash -c "cd vm-scalability/; bash -x ./case-lru-file-readtwice m"& done

#kick testing
for i in `docker ps | sed '1 d' | awk '{print $1 }'` ;do docker exec --privileged=true -it $i bash -c "cd vm-scalability/; bash -x ./case-lru-file-readtwice r"& done

#show result
for i in `docker ps | sed '1 d' | awk '{print $1 }'` ;do echo === $i ===; docker exec $i bash -c 'cat /tmp/vm-scalability-tmp/dd-output-* '  & done | grep MB | awk 'BEGIN {a=0;} { a+=$10 } END {print NR, a/(NR)}'
