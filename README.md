# Goals
1. Build the infrastructure to find temporal correlations between datasets (using Spark or Hadoop). Event detection: find correlations without and with event detection (any technique), to see if they can find correlations with rare events.
2. Choose some correlations that are potentially interesting and try to explain / come up with hypotheses, etc. For instance, how is the correlation for specific neighborhoods / zip codes?
3. Groups have the freedom to choose the temporal resolutions they will work on -- the more the merrier -- and they should also play with correlations for specific neighborhoods / zip codes when trying to explain a relationship. Any decision taken during the project (data cleaned, chosen resolution, architecture, etc.) must be written down on the final report.
4. Use Spearman's rank as a correlation measure.

# Datasets
1. Citi Bike Trip Histories

Example: 

`1 - 634,2 - 1372654800,3 - 1372655434,4 - 164,5 - $E 47 St & 2 Ave$,6 - 40.75323098,7 - -73.97032517,8 - 504,
9 - $1 Ave & E 15 St$,10 - 40.73221853,11 - -73.98165557,12 - 16950,13 - $Customer$,14 - $\N$,15 - $0$`

$value$ are ignored in data polygamy framework. "# - " appended to beginning of column values to indicate the column numbers only for demonstration purposes, not included in dataset.

# Run Project for Final Paper
### With Data Polygamy Framework 
1. Run the setup script to download/clean and upload datasets hdfs: `sh final_setup.sh`
2. Run final experiment: `sh final_exp.sh`
3. Get correlation measures:
```
cd correlation
sh get-correlations.sh
```
Correlations will be merged and downloaded to nyc directory.

# Results
Citibike (nyc) & Weather
https://github.com/akbisw/Citi-Bike-Big-Data/tree/master/correlation/correlations/nyc


# Run Project for Preliminary Report
1. Clone the repo: `git clone https://github.com/akbisw/Citi-Bike-Big-Data.git`
2. Change dir into the repo: `cd Citi-Bike-Big-Data`
3. Run the setup script to download datasets and setup hdfs: `sh setup.sh`
4. Run the experiment: `run_experiment.sh`

Charts and pretty print results have not been scripted yet.

But the correlations from our test run can be found here: https://github.com/akbisw/Citi-Bike-Big-Data/tree/master/correlations and the relationship result can be found here: https://github.com/akbisw/Citi-Bike-Big-Data/blob/master/performance-evaluation/output-events/weather-citibike-hour-city-events-restricted
