#------------------------------
# R version 3.4.1 (2017-06-30)
#
# @ Author: yoda
# @ Thu Jul 27 23:06:20 2017
# @ Asia/Seoul
#------------------------------

install.packages("MASS")
library(MASS)
data(Aids2)
str(Aids2) # 7개변수, 2843개 관측치

?Aids2

head(Aids2)
summary(Aids2)
Aids2[which(Aids2$age==0), ]

alive <- Aids2[which(Aids2$status=="A"),]
dead <- Aids2[which(Aids2$status=="D"),]
alive
?aggregate

# aggregate(data, by=list(기준이 될 그룹), function)
aggregate(alive$age, by=list(alive$sex), mean)
aggregate(dead$age, by=list(dead$sex), mean)

aggregate(Aids2$age, by=list(Aids2$sex, Aids2$status), mean)
