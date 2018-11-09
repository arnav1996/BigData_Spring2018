#!/usr/bin/env bash
# Scalar Function Computation
N=4
# generate all possible scalar functions at different spatio-temporal resolutions
for filename in `hadoop fs -ls data | awk '{print $NF}' | grep "data/[A-Z]" |  tr '\n' ' ' | sed 's/data\///g'`
do
    ((i=i%N)); ((i++==0)) && wait
    hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.standard_techniques.CorrelationTechniques -f -m cusp -n 20 -g1 $filename -g2 weather      &
done

# scalar functions for whole city 
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.standard_techniques.CorrelationTechniques -f -m cusp -n 20 -g1 citibike2013to2017clean -g2 weather
