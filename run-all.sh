#!/bin/bash 

# $1 - path/to/aspect, e.g. /home/dealii/aspect/aspect-release OR $HOME/aspect/build/aspect
# use low-res flag -l if desired

# on local PC: 
# ./run-all.sh /home/dealii/aspect/aspect-release -l

# on Niagara
# ./run-all.sh $HOME/aspect/build/aspect

for tag in v1.1 v1.2 v2.1 v2.2 v2.3 v3.1 v3.2 v4.1 v4.2 v4.3 v5.1 v5.2 v6.1 v6.2 v6.3 v6.4 v7.1 v7.2 v7.3 v7.4 v8.1 v8.2 v8.3 v9.1 v9.2 v9.3
do
  echo $tag $1 $2
  ./run-tag.sh $tag $1 $2
done