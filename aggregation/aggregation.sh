#!/usr/bin/env bash
# Scalar Function Computation
N=7
# generate all possible scalar functions at different spatio-temporal resolutions
for filename in `hadoop fs -ls data | awk '{print $NF}' | grep "data/[A-Z]" |  tr '\n' ' ' | sed 's/data\///g'`
do
    ((i=i%N)); ((i++==0)) && wait
    hadoop jar ../data-polygamy.jar edu.nyu.vida.data_polygamy.scalar_function_computation.Aggregation -f -m cusp -n 20 -g ${filename,,} 0 0 weather 0 0       &
done

# scalar functions for whole city 
hadoop jar ../data-polygamy.jar edu.nyu.vida.data_polygamy.scalar_function_computation.Aggregation -f -m cusp -n 20 -g citibike2013to2017clean 0 0 weather 0 0
# weather gas-prices-ny and citibike
hadoop jar ../data-polygamy.jar edu.nyu.vida.data_polygamy.scalar_function_computation.Aggregation -f -m cusp -n 20 -g citibike2013to2017clean 0 0 weather 0 0 gas-prices 0 0
