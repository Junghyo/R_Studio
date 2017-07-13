# 5장 연습문제
# 1. iris3 데이터 셋을 대상으로 다음 조건에 맞게 산점도를 그리시오
# 1-1 iris 데이터 셋의 컬럼명 확인
install.packages("plyr")
require(plyr)
str(iris3) # 50행, 4열, 3면(setosa, versicolor, virginica)
attributes(iris3)
colnames(iris3) # "Sepal L." "Sepal W." "Petal L." "Petal W."
# 1-2 iris3 데이터 셋의 구조 보기
mode(iris3); class(iris3) # numeric, array
# 1-3 산점도 그리기
postscriptFonts()
pdf.options(family="Korea1deb")
pdf("C:/R_Studio/Rscript/chapter_ex/chapter05/ex1_iris3.pdf")
plot(iris3, main="iris3 전체 데이터 셋의 분포현황")
plot(iris3[,1,1]~iris3[,3,1], main="iris3 데이터셋의 setosa 분포현황",
     xlab="Petal-Length", ylab="Sepal-Length")
plot(iris3[,2,2]~iris3[,4,2], main="iris3 데이터셋의 versicolor 분포현황",
     xlab="Petal-Width", ylab="Sepla-Width")
plot(iris3[,3,3]~iris3[,2,3], main="iris3 데이터셋의 virginica 분포현황", 
     xlab="Sepal-Width", ylab="Petal-Width")
dev.off()

# 2. iris 데이터 셋을 대상으로 다음 조건에 맞게 시각화하시오.
# 2-1 1번 컬럼(x축), 3번 컬럼(y축)
# 2-2 5번 컬럼으로 색상 지정
# 2-3 "iris 종별 " 제목 추가
# 2-4 다음 조건에 맞게 작성한 차트를 파일에 저장하기(jpg 형식, 폭:720px, 높이:480px)
str(iris)
colnames(iris)
levels(iris$Species) # "setosa" "versicolor" "virginica"
pdf("C:/R_Studio/Rscript/chapter_ex/chapter05/ex2_iris.pdf")
plot(iris[iris$Species=="setosa",]$Sepal.Length~iris[iris$Species=="setosa",]$Petal.Length,
     main="setosa")
plot(iris[iris$Species=="versicolor",]$Sepal.Length~iris[iris$Species=="versicolor",]$Petal.Length,
     main="versicolor")
plot(iris[iris$Species=="virginica",]$Sepal.Length~iris[iris$Species=="virginica",]$Petal.Length,
     main="virginica")
dev.off()

jpeg("C:/R_Studio/Rscript/chapter_ex/chapter05/iris.jpg", width=720, height=480)
plot(iris$Sepal.Length~iris$Petal.Length, col=iris$Species)
# black : setosa, red : versicolor, green : virginica
title("종별 꽃잎길이와 꽃받침길이 분포현황")
legend(6,5.5,c("setosa","versicolor","virginica"), col=c("black","red","green"),pch=1)
dev.off()
