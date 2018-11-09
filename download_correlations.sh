#!/usr/bin/env bash
# Create correlations directory
mkdir correlations
cd correlations
# Download all the correlations
hdfs dfs -getmerge correlations/weather-citibike/day-city weather-citibike-day-city
hdfs dfs -getmerge correlations/weather-citibike/hour-city weather-citibike-hour-city
hdfs dfs -getmerge correlations/weather-citibike/week-city weather-citibike-week-city
hdfs dfs -getmerge correlations/weather-citibike/month-city weather-citibike-month-city
hdfs dfs -getmerge correlations/weather-citibike/year-city weather-citibike-year-city
