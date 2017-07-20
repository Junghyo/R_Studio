# 범주형 자료분석 독립성 검정

# 30세 이상의 성인남자를 대상으로 흡연율을 조사한 결과 다음과 같은 결과표를 얻었다.
# 유의수준 5%에서 각 연령층별로 흡연율에 차이가 있는지 검정하라.
# H0 : 연령별로 흡연율은 차이가 없다.
# H1 : not H0

# 데이터 matrix
smoke <- matrix(c(95, 65, 40, 50, 80, 40, 25, 5), nrow=4, byrow=T)
dimnames(smoke) <- list(c("30대", "40대", "50대", "60대"), c("흡연자", "비흡연자"))
smoke
# 데이터 data.frame
smoke_df <- data.frame(c(95, 40, 80, 25), c(65, 50, 40, 5))
names(smoke_df) <- c("흡연자", "비흡연자")
rownames(smoke_df) <- c("30대", "40대", "50대", "60대")
dim(smoke_df)

# 기대도수 구하기
expect <- function(x){
  outer(rowSums(x), colSums(x))/sum(x)
}
expect(smoke_df) # 기대도수

# 검정통계량 구하기
test <- function(x){
  exValue <- outer(rowSums(x), colSums(x))/sum(x)
  sum( (exValue-x)^2/exValue )
}
testValue <- test(smoke_df)

# 가설검정
# 1. 검정통계량과 임계값으로 판단
testValue # 검정통계량값 : 18.12789
crValue <- qchisq(0.95, 3) # 임계값 : 7.81
crValue
if(testValue > crValue){
  cat("H0 reject")  
}else{
  cat("H0 accept")
}

# 2. pvalue 계산
pValue <- 1-pchisq(testValue, 3)
pValue
if(pValue < 0.05){
  cat("H0 reject")  
}else{
  cat("H0 accept")
}

# 3. chisq.test
# 범주형 자료분석의 경우 data.frame보다는 
# 반드시 matrix로 변형시켜서 하는 것을 권장

# smoke_df를 matrix로 변형
smoke_mt <- as.matrix(smoke_df)

# addmargins() : marginal distribution
addmargins(smoke_mt)

# prop.table() : proportional distribution 
# 관측치를 n으로 나눈 것
prop.table(smoke_mt)

# bar plot : barplot()
t(smoke_mt)
barplot(t(smoke_mt), beside=TRUE, legend=TRUE, col=rainbow(2),
          ylim=c(0, 100), 
          ylab="빈도수", 
          main="연령대별 흡연자, 비흡연자 빈도수")

# chi-squared test : chisq.test()
chisq_result <- chisq.test(smoke_mt)
chisq_result
# indexing statistics of chisq.test()
chisq_result$statistic # 검정통계량
chisq_result$parameter # 자유도
chisq_result$p.value # p값
chisq_result$observed # 관측도수
chisq_result$expected # 기대도수
chisq_result$stdres # 표준화잔차(여기선 무의미)
