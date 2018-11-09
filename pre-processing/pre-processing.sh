#!/usr/bin/env bash
# Pre-Processing
# hadoop fs -ls data | awk '{print $NF}' | grep "data/[A-Z]" |  tr '\n' ' ' | sed 's/data\///g'
N=10
# Pre Process neighborhoods
for filename in `hadoop fs -ls data | awk '{print $NF}' | grep "data/[A-Z]" |  tr '\n' ' ' | sed 's/data\///g'`
do
    ((i=i%N)); ((i++==0)) && wait
    hadoop jar ../data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn ${filename,,} -dh citibike.header -dd citibike.defaults -t hour -s nbhd -cs points -i 1 6 5 2 10 9          &
done
# Citi Bike Merged Dataset
hadoop jar ../data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn citibike2013to2017clean -dh citibike.header -dd citibike.defaults -t hour -s nbhd -cs points -i 1 6 5 2 10 9

# Preprocess weather and gas prices datasets
hadoop jar ../data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn weather -dh weather.header -dd weather.defaults -t hour -s city -cs city -i 0 0
hadoop jar ../data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn gas-prices -dh gas-prices.header -dd gas-prices.defaults -t week -s city -cs city -i 0 0
