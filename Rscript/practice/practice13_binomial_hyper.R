#------------------------------
# R version 3.4.1 (2017-06-30)
#
# @ Author: yoda
# @ Wed Jul 26 23:56:17 2017
# @ Asia/Seoul
#------------------------------

# binomial distribution

# 이항분포를 B(n,p)로 나타낼 때 
# 평균값 m은 m=np, 분산 σ2은 σ2=np(1-p)이며, 
# p가 0이나 1에 가깝지 않고 n이 충분히 크면
# 이항분포는 정규분포에 가까워진다.

# dbinom(성공횟수, 던진횟수, 확률)

# 동전을 100번 던졌을때 이항분포 그리기(p=0.5)
n = 100  # 시행횟수
n = 100  # 시행횟수
property1 <- numeric(length=n)
property2 <- numeric(length=n)
property3 <- numeric(length=n)
p1 = 0.5 # 성공확률
p2 = 0.2 # 성공확률
p3 = 0.8 # 성공확률
X = 0:n # 0 ~ n
p_f = c(p2, p1, p3)
for (i in 1:n+1){
  property1[i] <- dbinom(i-1, n, p1)
}

for (i in 1:n+1){
  property2[i] <- dbinom(i-1, n, p2)
}
for (i in 1:n+1){
  property3[i] <- dbinom(i-1, n, p3)
}
pdf("C:/R_Studio/Rscript/practice/p13_binomial_hyper_dist.pdf")
plot(X, property1, col="red", ylim=c(0, 0.15), type="l",
     ylab="property", xlab="trial")
lines(X, property2, col="green")
lines(X, property3, col="blue")
legend(60, 0.15, c("p=0.2", "p=0.5", "p=0.8"), col=c("red", "green", "blue"), lwd=1)
title(main="binomial distribution [n=100, p=c(0.2, 0.5, 0.8)]")
# 성공확률(p)가 커질수록 왼쪽으로 꼬리가 긴 분포(오른쪽으로 치우친 분포)
# 형태를 띈다




# hypergeometric distribution 

# N개의 공 중에 하얀 공이 m개, 검은 공이 (N-m)개 있다고 하자.
# k개의 공을 복원추출로 뽑는다면 하얀 공의 수는
# 모수가 (k, m/N)인 이항분포를 따른다.

# k개의 공을 비복원추출로 뽑을 때, 하얀 공의 수는
# 모수가 (N, m, k)인 초기하분포를 따른다.

# 이산확률변수 X가 초기하분포를 따르면 초기하확률변수라 하고
# X~HG(N, m, k)로 나타낸다.

# E(x) = mk/N, V(x) = mk(N-m)(N-k)/N²(N-1)
# 여기서 p = m/N, q = 1-(p)


# 성공확률0.4, 10번시도해서 3번 성공할 확률
dbinom(3, 10, 0.4)


# 남자가 40% 여자가 60%인 반에서 10명을 임의로 뽑아서 3명이 남자일 확률
dhyper(3, 8, 12, 10)
dhyper(3, 24, 36, 10)

a <- 100
property <- numeric(length=a)

for(i in 1:a){
  property[i] <- dhyper(3, 8*i, 12*i, 10)
}


property

plot(property[1:length(property)])
abline(h=dbinom(3, 10, 0.4), col="red")
title(main="hypergeometric distribution[dhyper(3, 8*i, 12*i, 10)]")
dev.off()
# 총 N이 커질수록 점점 dbinom 값에 근사하게 된다.
