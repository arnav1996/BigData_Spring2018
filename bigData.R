#library(ff)
#citi <- read.csv.ffdf(file='~/Downloads/citibike2013to2017.csv')


citi <- read.csv('citibike', header=FALSE)
colN <- read.csv('citibike.header')

library(plyr)
library(ggplot2)
library(anytime)
library(ggpubr)

colnames(citi) = colnames(colN)

#summary(citi$date)

citi$date <- anydate(citi$starttime)

citi_day <- ddply(citi, .(date), summarize, trips = length(tripduration))

trip <- ggplot(data=citi_day, aes(x=date, y=trips)) + geom_line(color="light blue")+ geom_point(aes(color = 'light purple', stroke = 0), show.legend = F) + ylab('Num. of Trips')
trip

weather <- read.csv('weather', header=FALSE)
colW <- read.csv('weather.header')
colnames(weather) = colnames(colW)
weather$date = anydate(weather$time)

weather$Temp.Temp.[weather$Temp.Temp.==999] <- NA
weather_day <- ddply(weather, .(date), summarize, measurement = mean(Temp.Temp., na.rm=TRUE))

minimum <- min(citi$date)
maximum <- max(citi$date)
weather_day <- subset(weather_day, date>=minimum & date<=maximum)

temp <- ggplot(data=weather_day, aes(x=date, y=measurement)) + geom_line(color="light blue")+ geom_point(aes(color = 'light purple', stroke = 0), show.legend = F) + ylab('Average Temp.') 


weather$Spd.Wind.[weather$Spd.Wind.==999.9] <- NA
wind_speed_day <- ddply(weather, .(date), summarize, measurement = mean(Spd.Wind., na.rm=TRUE))

wind_speed_day <- subset(wind_speed_day, date>=minimum & date<=maximum)

wind <- ggplot(data=wind_speed_day, aes(x=date, y=measurement)) + geom_line(color="light blue")+ geom_point(aes(color = 'light purple', stroke = 0), show.legend = F) + ylab('Average Wind Spd') 


ggarrange(trip, temp, wind, 
          align='v',
          ncol = 1, nrow = 3)



# library(sparklyr)
# 
# con <- spark_connect(master = "yarn-client")
# 
# tbl(con, "mytable") # dplyr
# dbGetQuery(con, "SELECT * FROM mytable") # SQL
# 
# spark_disconnect(con)
