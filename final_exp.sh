#!/usr/bin/env bash
# Pre-Processing
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn citibike -dh citibike.header -dd citibike.defaults -t hour -s nbhd -cs points -i 1 6 5 2 10 9
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn weather -dh weather.header -dd weather.defaults -t hour -s city -cs city -i 0 0
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn gas-prices -dh gas-prices.header -dd gas-prices.defaults -t week -s city -cs city -i 0 0

# Step 1: Scalar Function Computation
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.scalar_function_computation.Aggregation -f -m cusp -n 20 -g citibike 0 0 weather 0 0
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.scalar_function_computation.Aggregation -f -m cusp -n 20 -g citibike 0 0 weather 0 0 gas-prices 0 0

# Step 2: Feature Identification
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.feature_identification.IndexCreation -f -m cusp -n 20 -g citibike weather
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.feature_identification.IndexCreation -f -m cusp -n 20 -g citibike weather gas-prices

# Step 3: Relationship Computation
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.relationship_computation.Relationship -f -r -m cusp -n 20 -g1 citibike -g2 weather gas-prices

# Step 4: Correlation Computation
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.standard_techniques.CorrelationTechniques -f -m cusp -n 20 -g1 citibike -g2 weather gas-prices
