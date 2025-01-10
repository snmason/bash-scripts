#!/bin/bash

## 
# This script finds all nodes with the configured label, and then counts the number of pods on each node adding them up. 
# Simply set the label in the nodes variable as desired. 
##

set -e

NODES=( $(kubectl get nodes -l role=primary | awk '{print $1}' | tail -n +2) )
NUMOFPODS=0

for node in ${NODES[@]}; do
COUNTER=( $(kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=$node | awk '{print $2}' | tail -n +2 | wc -l) )
(( NUMOFPODS += COUNTER))
done

echo $NUMOFPODS
