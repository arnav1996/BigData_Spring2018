#!/usr/bin/env bash
# Download Datasets
cd data
if [ ! -f weather ]; then
    wget https://ndownloader.figshare.com/files/4975923 --no-check-certificate -O weather;
fi
if [ ! -f citibike ]; then
    wget https://ndownloader.figshare.com/files/4944970 --no-check-certificate -O citibike;
fi
# Prepare HDFS
sh load-hdfs-structure
# Load Spacial Data
sh load-spatial
# Load datasets (weather and citibike)
sh load-datasets
