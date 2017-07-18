# Chi-square test

# 1. 적합도 검정
# 모집단에서 가정된 이론적 분포와 관측된 표본에서의 분포 사이에 차이가 있는지를 평가하여
# 가정된 분포가 타당한지의 여부를 확인하는 것
# ex) H0 : 성인의 신장은 정규분포를 따른다 
#     H1 : not H0

# 2. 독립성 검정
# 하나의 모집단에서 추출된 표본이 두 가지의 특성에 분류된 경우, 두 특성간에 어떤 연관성이
# 있는지를 검정하는 것
# ex) 360명을 임의로 뽑아 정치성향과 나이에 따라 분류한 결과
#     HO : 정치 성향과 나이는 독립이다(연관성이 없다)
#     H1 : not H0

# 3. 동질성 검정
# 여러개의 모집단들로부터 추출된 각 표본들이 하나의 특성에 대해 몇 개의 범주로 분류되었을 때,
# 이 모집단들이 주어진 특성에 대해 서로 동일한 분포를 따르는지 여부를 검정하는 것
# ex) 성인 남성들을 대상으로 흡연율을 조사하는 경우 (10대~40대 연령별로 분류)
#     H0: 연령별에 따른 흡열율의 차이는 없다.
#     H1: not H0

# 동질성 검정 예시(Chi-Square Homogeneity Test)
answer <- matrix(c(42, 30, 50, 87), nrow=2, byrow=F)
dimnames(answer) <- list(c("man", "female"), c("yes", "no"))
answer
# ex)  man  : yes 42, no 50
#    female : yes 30, no 87
# H0 : 남녀별 대답의 차이는 없다
# h1 : not HO
expect <- function(Obs){
  outer(rowSums(Obs), colSums(Obs))/sum(Obs)
}
expect(answer) # expected value : man(yes 31.69378, no 60.30622)
              #               female(yes 40.30622, no 76.69378)

rs <- rowSums(answer) # man : 92, female : 117
cs <- colSums(answer) # yes : 72, no : 137

outer(rs, cs) #   man : yes 6624=92*72,  no 12604=92*137
              # women : yes 8424=117*72, no 16029=137*117

sum(answer) # total observed value : 209

outer(rs, cs)/sum(answer) # expected value

chisq <- function(Obs){
  Expected <- outer(rowSums(Obs), colSums(Obs))/sum(Obs)
  sum( (Obs-Expected)^2/Expected )
}
test<-chisq(answer) # test statistic  : 9.132947
test
# 1. 임계값과 비교하기.
# 보통 significance-level 5%에서 검정하는 것이 일반적
# critical value : qchisq(1-significance-level, df)
# degree of freedom : (nrow-1)(ncol-1)
qchisq(0.95, 1) # 3.841459

if(test>qchisq(0.95,1)){
  cat("H0 reject")
}else{
  cat("H0 accept")
}


# 2. p-value로 판단하기
# p-value : 1-pchisq(test statistic, df)
# degree of freedom : (nrow-1)(ncol-1)
pvalue <- 1-pchisq(9.132947, 1)  
pvalue # 0.00251047 ===> H0 reject
if(pvalue<0.05){
  cat("H0 reject")
}else{
  cat("H0 accept")
}

# 3. Pearson's Chi-squared test
chisq.test(answer) # X-squared = 8.2683, df = 1, p-value = 0.004034
# 값이 다르다. Yates' continuity correction 때문(수정됨)
# 현재 데이터들이 연속형보다는 이산형에 가깝다
# 그래서 프로그래밍에서 자동적으로 연속형 분포로 근사시켜 주는데 이때 보정이 들어가기 때문
# 결과는 똑같이 H0 reject 이나 제대로 바꿔주도록 한다.

chisq.test(answer, correct=F) # X-squared = 9.1329, df = 1, p-value = 0.00251
# 값이 동일하게 나오는 것을 확인할 수 있다.
