# Set up
Args <- commandArgs()
setwd(Args[6])
cat("Current work dir:"," ")
getwd()
dataPath <- paste(getwd(),Args[7], sep = "/")
cat("Data path: ",dataPath,"\n")

# Readin data
WL <- read.table(paste(dataPath,"AQ_FSPMC_WanLiu.csv",sep="/"),skip = 3,header = TRUE, sep = ",")
USE <- read.table(paste(dataPath,"AQ_FSPMC_USEmbassy.csv",sep="/"),skip = 3,header = TRUE, sep = ",")
PRE <- read.table(paste(dataPath,"A_PRE.csv",sep = "/"),skip = 3,header = TRUE, sep = ",")
TEMP <- read.table(paste(dataPath,"A_TEMP.csv",sep = "/"),skip = 3,header = TRUE, sep = ",")
RH <- read.table(paste(dataPath,"A_RH.csv",sep = "/"),skip = 3,header = TRUE, sep = ",")
WIND <- read.table(paste(dataPath,"A_WIND.csv",sep = "/"),skip = 3,header = TRUE, sep = ",")

# Convert time: from factor/integer to strptime
RH$TimeST <- strptime(as.character(RH$Time),format = "%Y/%m/%d %H:%M:%S")
RH_Weekly_Mean <- aggregate(X. ~ cut(TimeST,"1 week"), RH, mean)
colnames(RH_Weekly_Mean)[1] <- "WeeklyTime"
RH_Weekly_Mean$WeeklyTimeST <- strptime(as.character(RH_Weekly_Mean$WeeklyTime),format = "%Y-%m-%d")
# Plot
jpeg("Test_output.jpeg",width = 1200,height = 600)
plot(RH_Weekly_Mean$WeeklyTimeST,RH_Weekly_Mean$X.,pch=3,lty=1,xaxt="n", type = "o",xlab = "Date",ylab = "Relative Humidity")
title("Relative Humidity")
legend("topleft","top","Relative Humidity",pch=3,lty=1)
dev.off()
