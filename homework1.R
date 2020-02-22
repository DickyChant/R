# Set up
setwd("~/codes/R")
dataPath="rData"

# Readin data
WL <- read.table(paste(dataPath,"AQ_FSPMC_WanLiu.csv",sep="/"),skip = 3,header = TRUE, sep = ",")
USE <- read.table(paste(dataPath,"AQ_FSPMC_USEmbassy.csv",sep="/"),skip = 3,header = TRUE, sep = ",")
PRE <- read.table(paste(dataPath,"A_PRE.csv",sep = "/"),skip = 3,header = TRUE, sep = ",")
TEMP <- read.table(paste(dataPath,"A_TEMP.csv",sep = "/"),skip = 5,header = TRUE, sep = ",",
                   col.names = c("Date","Time","Height","DegreeCelsius","Source","ErrFlag","Details"),
                   colClasses = c("character","character",NA,NA,NA,NA,NA))
RH <- read.table(paste(dataPath,"A_RH.csv",sep = "/"),skip = 3,header = TRUE, sep = ",")
WIND <- read.table(paste(dataPath,"A_WIND.csv",sep = "/"),skip = 3,header = TRUE, sep = ",")

# Convert time: from factor/integer to strptime
RH$TimeST <- strptime(as.character(RH$Time),format = "%Y/%m/%d %H:%M:%S")
RH_Weekly_Mean <- aggregate(X. ~ cut(TimeST,"1 week"), RH, mean)
colnames(RH_Weekly_Mean)[1] <- "WeeklyTime"
RH_Weekly_Mean$WeeklyTimeST <- strptime(as.character(RH_Weekly_Mean$WeeklyTime),format = "%Y-%m-%d")
# Plot
plot(RH_Weekly_Mean$WeeklyTimeST,RH_Weekly_Mean$X.,pch=3,lty=1,xaxt="n",yaxt="n", type = "o",xlab = "Date",ylab = "Relative Humidity", 
     main = "Relative Humidity: Weekly Averaged")
legend("topleft","top","Relative Humidity",pch=3,lty=1)
labelRH =  strftime(RH_Weekly_Mean$WeeklyTimeST,"%m/%d")
axis(1, at=as.numeric(RH_Weekly_Mean$WeeklyTimeST), labels=labelRH, col.axis="black", las=2, cex.axis=0.7, tck=-0.02)
i <- c(1:6)
ypos <- (i-1)*20
axis(2, at=ypos, col.axis="black", las=1, cex.axis=0.7, tck=-0.02)
abline(h=c(50), lty=2, col="red")

PRE$TimeST <- strptime(as.character(PRE$Time),format = "%Y/%m/%d %H:%M:%S")
PRE_Weekly_Mean <- aggregate(Pascal ~ cut(TimeST,"1 week"), PRE, mean)
colnames(PRE_Weekly_Mean)[1] <- "WeeklyTime"
PRE_Weekly_Mean$WeeklyTimeST <- strptime(as.character(PRE_Weekly_Mean$WeeklyTime),format = "%Y-%m-%d")
plot(PRE_Weekly_Mean$WeeklyTimeST,PRE_Weekly_Mean$Pascal,pch=3,lty=1,cex.lab=1, type = "o",xlab = "Date",ylab = "Relative Humidity", 
     main = "Relative Humidity: Weekly Averaged",col="blue")