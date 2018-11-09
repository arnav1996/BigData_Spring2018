#!/usr/bin/env bash
# Set environment for pyspark
module load python/gnu/3.4.4 spark/2.2.0 git/1.8.3.1
export PYTHONHASHSEED=0
export SPARK_YARN_USER_ENV=PYTHONHASHSEED=0
export PYSPARK_PYTHON='/share/apps/python/3.4.4/bin/python'
export PYSPARK_DRIVER_PYTHON='/share/apps/python/3.4.4/bin/python'

# Upload the merged dataset to hdfs
hdfs dfs -mkdir data
hdfs dfs -put citibike2013to2017 data/
rm citibike2013to2017
# Run the spark program to 
# 1. clean the merged citi bike dataset
# 2. convert the date to epoch format
# ... more things 
# output directory is set to data/citibike2013to2017
spark-submit clean-citibike.py data/citibike2013to2017

# getmerge the output
hdfs dfs -getmerge data/citibike2013to2017.final citibike2013to2017.csv

# Upload it back to hdfs
hdfs dfs -put data/citibike2013to2017.csv data/citibike2013to2017

# Rm citibike2013to2017.csv locally and the hadoop results
rm citibike2013to2017.csv
hdfs dfs -rm -r data/citibike2013to2017.final
