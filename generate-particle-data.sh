#!/bin/bash

file="data/particle.dat"
echo "# Columns: x_coordinate y_coordinate" > "$file"

for y in 400000 439000 390000 375000 350000
    do
    # generate surface topography particles
    for x in {0..800000..2000}
    do
        echo "$x.0 $y.0" >> "$file"
    done
done
# total = 401*5 = 2005 particles