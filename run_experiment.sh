#!/usr/bin/env bash
# Pre-Processing
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn citibike -dh citibike.header -dd citibike.defaults -t hour -s nbhd -cs points -i 1 6 5 2 10 9
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.pre_processing.PreProcessing -m cusp -n 20 -dn weather -dh weather.header -dd weather.defaults -t hour -s city -cs city -i 0 0

# Step 1: Scalar Function Computation
# Step 2: Feature Identification
# Step 3: Relationship Computation
cd performance-evaluation
sh run-varying > run-varying.out
python running-time-preprocessing.py metadata/ run-varying.out True

# Step 4: Correlation Computation
cd ..
hadoop jar data-polygamy.jar edu.nyu.vida.data_polygamy.standard_techniques.CorrelationTechniques -f -m cusp -n 20 -g1 citibike -g2 weather
