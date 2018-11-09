# How to split Citibike data
### Download merged dataset
https://drive.google.com/uc?export=download&confirm=gVzO&id=1nnTH5G9tIwbRvn35HXrm_pqz1HqRL1i5


### Add neighborhood column to the merge data
`python addNbhdCol.py`

### Add header to the csv
`sed -i '1itripduration,starttime,stoptime,start-station-id,start-station-name,start-station-latitude,start-station-longitude,end-station-id,end-station-name,end-station-latitude,end-station-longitude,bikeid,usertype,birth-year,gender,nbhd' citibike2013to2017nbhd.csv`

### Move to HDFS
`hadoop dfs -put citibike2013to2017nbhd.csv data/`

### Spark job to split the dataset based on neighborhood
`spark-submit split-citibike.py data/citibike2013to2017nbhd.csv`

### Loop through, merge each neighborhood data
```
#!/usr/bin/env bash

for filename in `hadoop fs -ls nbhdtest2 | awk '{print $NF}' | grep "nbhd=" | tr '\n' ' '`
do
    IFS='=' read -a string <<< "$filename"
    file=${string[1]}
    echo "Writing $file to $file.csv"
    hadoop dfs -getmerge $filename $file
    hadoop dfs -put $file data/
done
```
