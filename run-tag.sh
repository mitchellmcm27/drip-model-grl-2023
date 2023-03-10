#!/bin/bash
lowres=false

if [ "$3" == "-l" ]
then lowres=true
fi

echo $1 $2 $3

{
    echo "include models/v0.prm"

    if [ -f "models/$1.prm" ]
    then 
        echo "include models/$1.prm"
    fi

    if [ -f "models/$1-phase-1.prm" ]
    then 
        echo "include models/$1-phase-1.prm"
    fi

    if [ "$lowres" = true ]
    then
        echo "include models/low-res.prm"
        echo "set Output directory = output-low-res-$1"
    else
        echo "set Output directory = output-$1"
    fi
} > input-$1.prm

mpirun $2 input-$1.prm
wait

{
    echo "include models/v0.prm"
    echo "include models/v0-phase-2.prm"

    if [ -f "models/$1.prm" ]
    then 
        echo "include models/$1.prm"
    fi

    if [ -f "models/$1-phase-2.prm" ]
    then 
        echo "include models/$1-phase-2.prm"
    fi

    if [ "$lowres" = true ]
    then
        echo "include models/low-res.prm"
        echo "set Output directory = output-low-res-$1"
    else
        echo "set Output directory = output-$1"
    fi
} > input-$1.prm

mpirun $2 input-$1.prm
exit 0