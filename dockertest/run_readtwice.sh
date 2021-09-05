#!/usr/bin/env bash
#
# Originally by Alex Shi <alex.shi@linux.alibaba.com>
# Changes from Daniel Jordan <daniel.m.jordan@oracle.com>

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TAG='lrulock'
runtime=300

#nr_cont=$(nproc)
nr_cont=2

cd "$SCRIPT_DIR"

echo -e "starting $nr_cont containers\n"

pids=()

sudo docker build -t "$TAG" .

nr_running_cont=$(sudo docker ps | sed '1 d' | wc -l)
if (( nr_running_cont != 0 )); then
	echo "error: $nr_running_cont containers already running"
	exit 1
fi

# start some testing containers
for ((i=0; i < nr_cont; i++)); do
	sudo docker run --privileged=true --rm "$TAG" bash -c "sleep infinity" &
done

nr_running_cont=$(sudo docker ps | sed '1 d' | wc -l)
until (( nr_running_cont == nr_cont )); do
	sleep .5
	nr_running_cont=$(sudo docker ps | sed '1 d' | wc -l)
done

# do testing evn setup 
for i in `sudo docker ps | sed '1 d' | awk '{print $1}'`; do
	sudo docker exec --privileged=true -t $i \
		bash -c "cd /vm-scalability/; bash ./case-lru-file-readtwice m" &
	pids+=($!)
done

wait "${pids[@]}"
pids=()

# kick testing
for i in `sudo docker ps | sed '1 d' | awk '{print $1}'`; do
	sudo docker exec --privileged=true -t -e runtime=$runtime $i \
		bash -c "cd /vm-scalability/; bash ./case-lru-file-readtwice r" &
	pids+=($!)
done

wait "${pids[@]}"
pids=()

# save results
ts=$(date +%y-%m-%d_%H:%M:%S)
f="$ts/summary.txt"

mkdir "$ts"
echo "$ts" >> "$f"
uname -r >> "$f"

#show result
for i in `sudo docker ps | sed '1 d' | awk '{print $1}'`; do
	sudo docker exec $i bash -c 'cat /tmp/vm-scalability-tmp/dd-output-*' &> "$ts/$i.out" &
	pids+=($!)
done

wait "${pids[@]}"
pids=()

grep 'copied' "$ts"/*.out | \
	awk 'BEGIN {a=0;} { a+=$10 } END {print NR, a/(NR)}' | \
	tee -a "$f"

for i in `sudo docker ps | sed '1 d' | awk '{print $1}'`; do
	sudo docker stop $i &>/dev/null &
done
wait

echo 'test finished'
echo
