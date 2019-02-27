#!/bin/bash
set -e

for H in 0.125 0.25 0.5 0.75;
do

    H_filename=${H//./_};
    cp -r fractional_brownian_template fractional_brownian_${H_filename}
    sed -i "s/HURZ_INDEX/${H}/g" fractional_brownian_${H_filename}/fractional_brownian.py
done
