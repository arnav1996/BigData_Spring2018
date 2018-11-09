import sys
from pyspark import SparkContext
from csv import reader
from datetime import datetime
import pytz

sc = SparkContext()
citibikeRdd = sc.textFile(sys.argv[1])
citibikeRdd = citibikeRdd.mapPartitions(lambda x : reader(x))

def try_parsing_date(text):
    for fmt in ('%Y-%m-%d %H:%M:%S', '%m/%d/%Y %H:%M:%S', '%m/%d/%Y %H:%M'):
        try:
            return datetime.strptime(text, fmt)
        except ValueError:
            pass
    raise ValueError('no valid date format found for this date: ' + text)

def map_date_to_epoch(local_time):
    # define timezones from pytz library
    utc = pytz.utc
    eastern = pytz.timezone('US/Eastern')
    # Create a datetime object for each time
    date = try_parsing_date(local_time)
    # Normalize (daylight) and localize (eastern time zone) the datetime objects
    date_est = eastern.normalize(eastern.localize(date,is_dst=True))
    # Convert to UTC
    date_utc = date_est.astimezone(utc)
    # Convert to epoch
    ts = (date_utc - datetime(1970, 1, 1, tzinfo=utc)).total_seconds()
    return int(ts)

def mapper(x):
    # Convert start and end dates to epoch
    x[1] = map_date_to_epoch(x[1])
    x[2] = map_date_to_epoch(x[2])
    # Add $$ around columns not required
    x[4] = '${}$'.format(x[4])
    x[8] = '${}$'.format(x[8])
    x[12] = '${}$'.format(x[12])
    x[13] = '${}$'.format(x[13])
    x[14] = '${}$'.format(x[14])
    # return the list as a csv string
    return ",".join(str(y) for y in x) 

citibikeRdd = citibikeRdd.map(mapper).saveAsTextFile("data/citibike2013to2017.final")
sc.stop()
