steelhead.r

#exposure model for steelhead

#read in data
setwd("/Users/mikehawkshaw/Dropbox/SteelheadModel/OpeningMatrices")

#fishery_mat<-read.csv("2010Area E_openings.csv")
#fishery_mat<-read.csv("2011Area E_openings.csv")
#fishery_mat<-read.csv("2012Area E_openings.csv")
#fishery_mat<-read.csv("2013Area E_openings.csv")
fishery_mat<-as.matrix(read.csv("2014Area E_openings.csv"))
#fishery_mat<-read.csv("2015Area E_openings.csv")
#fishery_mat<-read.csv("2016Area E_openings.csv")



fishery_mat<-as.matrix(read.csv("2014Area E_openings.csv"))

fishery_mat<-as.matrix(read.csv("2014Area B_openings.csv"))


colnames(fishery_mat)<-NULL
fishery_mat<-fishery_mat[,2:3337]

steelhead_data<-as.data.frame(read.csv("steelhead_pops.csv", header=T))

n_km<-521
n_hours<-3336

#set up a fake steelhead population
#IBM

n_fish<-1000
fish<-seq(1,n_fish,by=1)

#each fish has characteristics and they are in these vectors
exposure<-rep(NA,n_fish)
speeds<-rep(0,n_fish)
starting_date<-rep(0,n_fish)

#population characteristics (these are the hypothesis about the population that will be tested)
rt_mean<-100
rt_sd<-10
speed_mean<-20
speed_sd<-3

speeds<-(pmax(9,pmin(55,rnorm(fish,speed_mean,speed_sd))))/24	#speed in km/h
starting_date<-(pmax(15,pmin(85,rnorm(fish,rt_mean,rt_sd)))) #starting date in hours
starting_hour<-starting_date*24
#move fish though fisheries 

for(ind in 1:n_fish)
{

exposure[ind]<-0
for(loc in 1:n_km){

start_time<-starting_hour[ind]
time_at_loc<-start_time+loc*speeds[ind]

#check exposure against fishery matrix

exposure[ind]<-exposure[ind]+fishery_mat[loc,round(time_at_loc)]

}
}



boxplot(list(exposure_2010, exposure_2011, exposure_2012, exposure_2013, exposure_2014, exposure_2015, exposure_2016), names=c("2010","2011","2012","2013","2014","2015","2016"))
