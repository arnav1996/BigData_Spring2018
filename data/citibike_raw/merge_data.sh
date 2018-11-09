rm citibike2013to2017 && touch citibike2013to2017
# Merge 2013 data
for month in {07..12};
do
    cat 2013-$month\ -\ Citi\ Bike\ trip\ data.csv >> citibike2013to2017
done;
# Merge 2014 data
for month in {01..08};
do
    cat 2014-$month\ -\ Citi\ Bike\ trip\ data.csv >> citibike2013to2017
done;
for month in {09..12};
do
    cat 2014$month-citibike-tripdata.csv  >> citibike2013to2017
done;
# Merge 2015-2017 Data
for year in `seq 2015 2017`;     
do     
    for month in {01..12};
    do
        cat $year$month-citibike-tripdata.csv  >> citibike2013to2017
    done;     
done

# Remove all the monthly csv files
rm *.csv
