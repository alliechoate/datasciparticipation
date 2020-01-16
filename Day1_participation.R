# Day 1 - 1.16.20
# Participation for the day.

# commuting times for people
times<- c(17, 30, 25, 35, 25, 30, 40, 20)
mean(times)

# re-uses entire---a length 2 vector
times[times > 30]<- c(0,1)

timehours<- (times/60)
timehours


mean(times)
range(times)
sqrt(times)
times > 30
times == 17


which(times > 30) # number that is 4th and 7th in line are greater than 30
all(times > 30) ### are these ALL true? yes or nahhhh 

# pulling out info from vectorssszzdzsksdlk
times[[3]] 
times[-c(3)] # goodbye third value in vector
times[3:5] #values 3-5
times[times > 30] # 2 values that are greater than 30

times[1] <- 47 #changing first value to 47 while keeping the others the same
times[5]<- NA
times[times > 30]<- NA #all values above 30 = NA --- bye felicia 

# will re-cycle values by replacing 0 and then 1 for values >30
times[times > 30]<- c(0,1)



### working with NA values ---
# 17 30 25 NA 25 30 NA 20
mean(times, na.rm=TRUE) # 

mean(which(times > 25), na.rm=TRUE) # mean of values greater than 25
# for range of values between 25-30:
mean(times[times > 20 & times < 35], na.rm=T) #similar for 'OR' is '|' - vertical key line dude thingy

#useful for expamining mean without potential extreme data-points 
mean(times, .2, TRUE) #trimming off top 20 and top lowest 20% --'TRUE' corresponds to na.rm


### working with a datttaaaaaseeeeetttttttttttt or dataaaaframmmeeeeeeee
library(car)
mtcars # old cars and stuff 
dat<- mtcars 


head(dat, 3)
tail(dat, 4)
str(dat)
class(dat)
names(dat)

sdat<-lapply(X = dat,FUN = 'factor')
str(dat)
dat<- lapply(X=dat, FUN='as.numeric')
str(dat)














s# make sure to git push before finally committing...I think