rm(list=ls())
# ?????? ?ε? ####
data1 <- read.csv(file.choose())
str(data1)
###########################
data1$SOLDPRICE  <- as.numeric(data1$SOLDPRICE)
data1$relprice  <- as.numeric(data1$relprice)
data1$genGap   <- as.numeric(data1$genGap)
data1$DATEGAP   <- as.numeric(data1$DATEGAP)


str(data1)

library(Hmisc)
describe(data1)
describe(data1$KRNAME)

plot(data1$ID,data1$DATEGAP)
plot(data1$KRNAME,data1$DATEGAP)

plot(data1$SOLDPRICE)
hist(data1$SOLDPRICE)
summary(data1$SOLDPRICE)
describe(data1$SOLDPRICE)

str(data1)
##############################################################################
m<-lm(SOLDPRICE ~ MODEL+GB+CONTRACT+usim+skt+kt+lg+GUARANTEE+CHANGES+CONDITIONS+COMPONENT+SOLD
      +relprice+genGap+DATEGAP+PRICERATE, data1)
summary(m)
coef(m)

anova(m)

model.matrix(m)



################################################################################
m.step <- step(m, direction = "both")
m.step
formula(m.step)

multi.best.m<-lm(formula(m.step), data1)
summary(multi.best.m)
################################################################################
################################################################################
str(data1)
iphone7 <-  subset(data1, KRNAME == "?????? 7")

plot(iphone6$DATEGAP, iphone6$SOLDPRICE)


################################################################################
#logistic
################################################################################
logit <- glm(SOLD ~ MODEL+GB+CONTRACT+usim+skt+kt+lg+GUARANTEE+CHANGES+CONDITIONS+COMPONENT+SOLDPRICE
             +relprice+genGap+DATEGAP+PRICERATE, family=binomial, data1)
summary(logit)

step3 <- step(logit, direction = "both")
step3
formula(step3)

logit_best <- glm(formula(step3), family=binomial, data1)
logit_best
summary(logit_best)
#################################################################################
data2<-data.frame(data1$DATEGAP, data1$SOLDPRICE)

(cl <- kmeans(data2, 2))
plot(data2, col = cl$cluster)
points(cl$centers, col = 1:2, pch = 8, cex=2)
# random starts do help here with too many clusters
(cl <- kmeans(data2, 13, nstart = 25))
plot(data2, col = cl$cluster)
points(cl$centers, col = 1:5, pch = 13)

cl$cluster 
clust<- cbind.data.frame(data1, cl$cluster)

clust2<- data.frame(data1$KRNAME, clust$`cl$cluster`)
###
library(Hmisc)
describe(data2.one)
plot(data2.one$eclassct)


table(clust2)

######################################################################?ӽŷ???
#train-test partition 7:3
describe(data1$SOLD)
part<-createDataPartition(data1$SOLD,p=0.7)
ind.train<-part$Resample1
data2.train<-data1[ind.train,]
data2.test<-data1[-ind.train,]

library(Hmisc)
describe(data2.train$SOLD)
describe(data2.test$SOLD)




train_lr <- glm(SOLD ~ MODEL+GB+CONTRACT+usim+skt+kt+lg+GUARANTEE+CHANGES+CONDITIONS+COMPONENT+SOLDPRICE
                +relprice+genGap+DATEGAP+PRICERATE, family=binomial, data2.train)
summary(train_lr)
test.pred <- predict(train_lr, newdata=data2.test, type = "response")
test.pred

plot(test.pred)


new.train.step3 <- step(train_lr, direction = "both")
new.train.step3
formula(new.train.step3)

##???? ???? ?? ??????ƽ ȸ?? ?м?##########
##method : both
##formual : 


train_lr_best <- glm(formula(new.train.step3), family=binomial, data2.train)
train_lr_best
summary(train_lr_best)

test.pred1 <- predict(train_lr_best, newdata=data2.test, type = "response")
test.pred1
plot(test.pred1)

# Evaluate the logistic regression performance on the training data
test_target <- data2.test$SOLD
lr_trn_predicted_3 <- rep(0, length(test_target))
lr_trn_predicted_3[which(test.pred1 >= 0.4)] <- 1
lr_trn_predicted_3

data2.test$SOLD2 <- ifelse(data2.test$SOLD=="soldout", 1, 0)
data2.test$SOLD


library(caret)
confusionMatrix(lr_trn_predicted_3,data2.test$SOLD2)

#######################################################################################

data3 <- subset(data1, data1$PRICERATE >= 0)
plot(data3$DATEGAP, data3$PRICERATE)

#######################################################################################
library(rpart)
tree<-rpart(formula(m.step),data=data3,control=rpart.control(minsplit=2))
plot(tree)
text(tree)

tree

install.packages("rpart.plot")
library(rpart.plot)
prp(tree,type=4,extra=2,digits=3)


##########################################################################################
# Get the data points in form of a R vector.
rainfall <- c(799,1174.8,865.1,1334.6,635.4,918.5,685.5,998.6,784.2,985,882.8,1071)

# Convert it to a time series object.
rainfall.timeseries <- ts(rainfall,start = c(2012,1),frequency = 12)

# Print the timeseries data.
print(rainfall.timeseries)

# Give the chart file a name.
png(file = "rainfall.png")

# Plot a graph of the time series.
plot(rainfall.timeseries)

# Save the file.
dev.off()

head(EuStockMarkets)
str(EuStockMarkets)
EuStockMarkets
###########################################################################################
ts1 <- read.csv("C:/data/ts.csv")

#ts2<- ts[c(order(ts$POSTDATE)),]
head(ts1)
ts1$postdate <- as.factor(ts1$postdate)

str(ts1)
tail(ts1)
rainfall.timeseries <- ts(ts1,start = 1)

print(rainfall.timeseries)

# Plot a graph of the time series.
plot(rainfall.timeseries)

# Save the file.
dev.off()

?ts
