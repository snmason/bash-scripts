# Used to pull all images used in a kubernetes cluster. Dynamically pulls all namespaces and then spits out every image used in that namespace.

#!/bin/bash
set -e

namespaces=( $(kubectl get namespaces | awk '{print $1}' | tail -n +2))

for str in ${namespaces[@]}; do
    echo ''
    echo Namespace $str
    echo ''
    kubectl get pods -n $str -o jsonpath="{.items[*].spec.containers[*].image}" |
    tr -s '[[:space:]]' \\n |
    sort |
    uniq -c
done
