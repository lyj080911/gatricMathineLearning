rm(list=ls())
savepdf <- TRUE

library(RODBC)
channel <- odbcConnect("DB_BigData",uid="sa",pwd="test1234")
xmdict <- sqlQuery(channel,"select * from [OXMDict]")
jdata <- sqlQuery(channel,"SELECT * FROM [RunDataN] where tname in('??ֱ????ǰ????','????????','??ֱ??Ϣ??','??ֱ????')")
j_tempdata <- jdata

j_vflag <- apply(is.na(j_tempdata),1,mean)

rf_flag <- 0.7
cf_flag <- 0.7

jdata <- j_tempdata[which(j_vflag<rf_flag),]

nrow(jdata)

jonlydata <- jdata[jdata$tname=="??ֱ????",]

jo_flag <- apply(is.na(jonlydata),2,mean)
jdata <- jdata[,which(jo_flag<cf_flag)]

j_flag <- apply(is.na(jdata),2,mean)

#j_flag
jdata <- jdata[,which(j_flag<cf_flag)]

jdata <- jdata[,-c(1,2)]
if(savepdf){dev.off()}

ncol(jdata)
XM5<-0
for(i in 1:nrow(jdata))
{
  XM5[i]=c(as.numeric(as.character(jdata[i,"XM5"])))
}
jdata<-subset(jdata,select=-XM5)
jdata<-cbind(jdata,XM5)

--------------------------------------------------*/
