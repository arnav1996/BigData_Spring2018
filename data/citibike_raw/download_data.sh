# Download 2013 Data
for month in {07..12};
do
    wget https://s3.amazonaws.com/tripdata/2013$month-citibike-tripdata.zip;
done;
# Download 2014-2016 Data
for year in `seq 2014 2016`;     
do     
    for month in {01..12};
    do
        wget https://s3.amazonaws.com/tripdata/$year$month-citibike-tripdata.zip;     
    done;     
done
# Download 2017 Data
for month in {01..12};
do
    wget https://s3.amazonaws.com/tripdata/2017$month-citibike-tripdata.csv.zip;
done;
