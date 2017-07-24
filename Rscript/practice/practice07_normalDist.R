# Normal Distribution mean=80, sd=10
x <- seq(40, 120, length=300) # 40~120까지 300개의 수를 쪼갬(간격 동일)
x
y <- dnorm(x, mean=80, sd=10) # 
y
plot(x,y, type="l", col="red")
lines(x, dnorm(x, mean=80, sd=20), col="blue")

# a. probability between 65~75
x2 <- x[which(x>=65 & x<=75)]
y2 <- dnorm(x2, mean=80, sd=10)
# 다각형을 그리는 함수
polygon(c(65,x2,75), c(0,y2,0), col="grey") # 65~75 사이

pnorm # 안의 percentage(넓이)
qnorm # 넓이에 따른 x값을 보여줌
dnorm # x값에 따른 y값을 보여줌
rnorm # 난수 발생

# a. solution
a <- pnorm(75, mean=80, sd=10) # 75 까지의 확률 : 0.3085375
b <- pnorm(65, mean=80, sd=10) # 65 까지의 확률 : 0.0668072
a-b  # 65~75 넓이 : 0.2417303


# b. probability of over 92
pnorm(92, mean=80, sd=10) # 92 까지의 넓이 : 0.8849303
pnorm(92, mean=80, sd=10, lower.tail=T) # 92 까지의 확률 : 0.8849303

# b. solution
# 확률의 전체 합은 1이기에
1 - pnorm(92, mean=80, sd=10) # 92이상의 확률 : 0.1150697
pnorm(92, mean=80, sd=10, lower.tail=F) # 92이상의 확률 : 0.1150697


# c. probability of less than 68
pnorm(68, mean=80, sd=10) # 68 이하의 확률 : 0.1150697
# 92 확률과 대칭. 80+12 = 92, 80-12 = 68


# d. cutoff that separates the bottom 30%
qnorm(0.3, mean=80, sd=10) # 확률이 30%인 x의 값 : 74.75599
pnorm(74.75599, mean=80, sd=10) # 74.75599까지의 확률 : 0.2999998


# e. 80% percentile
qnorm(0.8, mean=80, sd=10) # 확률이 80%인 x의 값 : 88.41621
pnorm(88.41621, mean=80, sd=10)  # 88.41621까지의 확률 : 0.799999999


# f. cutoffs that contain the middle 60%
# 좌우 대칭이기에 하위 20%, 상위 80%를 자르면 된다.
c <- qnorm(0.2, mean=80, sd=10) # 71.58379
d <- qnorm(0.8, mean=80, sd=10) # 88.41621
pnorm(d, mean=80, sd=10)-pnorm(c, mean=80, sd=10) # 0.6
# 71.58379 ~ 88.41621
80-c # 8.416212
80-d # -8.416212

