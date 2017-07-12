# 시각화 도구 분류

#         칼럼특성                    시각화도구                  설명
# 칼럼수  숫자형  범주형
#   1       1                     hist, plot, barplot       숫자형 컬럼 1개
#   1               1             pie, barplot              범주형 컬럼 1개
#   2       2                     plot, abline, boxplot     숫자형 컬럼 2개
#   3       3                     scatterplot3d             숫자형 컬럼 3개
#   n       n       n             pairs(산점도 매트릭스)    n개의 컬럼

# 이산변수 : 정수 단위로 나누어 측정할 수 있는 변수 : barplot, pie, plot 이용

# barplot, hist 차이 : barplot은 범주형, hist는 연속형

# barplot : 세로막대, ylim(y축 범위), col(막대 색상), main(제목), cex.names=x축 문자 크기
chart_data <- c(305,405,320,460,330,480,380,520)
names(chart_data) <- c("2014 1분기", "2015 1분기", "2014 2분기", "2015 2분기",
                       "2014 3분기", "2015 3분기", "2014 4분기", "2015 4분기")
chart_data
mode(chart_data); class(chart_data) # numeric, numeric
postscriptFonts() # pdf 폰트 지원 확인하기 $Korea1deb
pdf.options(family="Korea1deb") # 한글 옵션 설정
pdf("C:/R_Studio/Rscript/chapter/chapter05/barplot.pdf")
par(mfrow=c(1,1))
barplot(chart_data, ylim=c(0,600), col=rainbow(8),
        main="2014년도 vs 2015년도 분기별 매출현황 비교", cex.names=0.9)

help(barplot) # barplot 도움말 보기

# 가로축, 세로축 레이블 추가 : xlab(x축이름), ylab(y축이름) 속성 이용
barplot(chart_data, ylab="매출액(단위:만원)", xlab="년도별 분기현황", ylim=c(0,600),
        col=rainbow(8), main="2014년도 vs 2015년도 분기별 매출현황 비교[xlab, ylab 설정]",
        cex.names=0.9)

# 가로 barplot : horiz 속성을 TRUE로 지정하면 된다.
barplot(chart_data, xlim=c(0,600), xlab="매출액(단위:만원)", ylab="년도별 분기현황",
        horiz=T, col=rainbow(8),
        main="2014년도 vs 2015년도 분기별 매출현황 비교[horiz=T]")

# 막대 사이 간격 조정 : space
barplot(chart_data, xlim=c(0,600), xlab="매출액(단위:만원)", ylab="년도별 분기현황",
        horiz=T, col=rainbow(8), space=1, cex.names=0.5,
        main="2014년도 vs 2015년도 분기별 매출현황 비교[horiz=T, spcae=1]")

# 막대 색상 특정색 지정 : 1(검정), 2(빨강), 3(초록), 4(파랑), 5(하늘색), 6(자주색), 7(노랑)
barplot(chart_data, xlim=c(0,600), xlab="매출액(단위:만원)", ylab="년도별 분기현황",
        space=1, cex.names=0.5, col=rep(c(2,4),4), horiz=T,
        main="2014년도 vs 2015년도 분기별 매출현황 비교[col=rep(c(2,4),4)]")
# 노랑과 그린 색상으로 지정
barplot(chart_data, xlim=c(0,600), xlab="매출액(단위:만원)", ylab="년도별 분기현황",
        space=1, cex.names=0.5, col=rep(c("green","yellow"),4), horiz=T,
        main="2014년도 vs 2015년도 분기별 매출현황 비교[col=rep(c(green,yellow),4)]")

# 누적 막대차트
# 단계 1 : 메모리 가져오기, 데이터 셋 확인하기
data(VADeaths)
VADeaths
str(VADeaths) # 5행 4열
mode(VADeaths); class(VADeaths) # numeric, matrix
dimnames(VADeaths) # names는 각 vector의 이름이고 dimnames는 각 행,열의 이름
rownames(VADeaths) # "50-54" "55-59" "60-64" "65-69" "70-74"
colnames(VADeaths) # "Rural Male"   "Rural Female" "Urban Male"   "Urban Female"
help(VADeaths)
par(mfrow=c(1,2)) # 1행 2열 그래프 보기(한화면에 2개)

# 단계 2: barplot 그리기(beside F, T 여부 확인)
# beside : X축 값이 측면으로 배열, F면 하나의 막대에 누적

# (1) beside=F
barplot(VADeaths, beside=F, col=rainbow(5), 
        main="Death Rates in Virginia (1940)[beside=F]", cex.names =0.5)
# legend : 범례표시. x좌표, y좌표, 범주 설정, 색상(fill), 크기(cex) 등
help(legend)
legend(3.8, 200, rownames(VADeaths), cex=0.8, fill=rainbow(5))

# (2) beside=T
barplot(VADeaths, beside=T, col=rainbow(5), cex.names =0.5)
legend(19,71,rownames(VADeaths), cex=0.8, fill=rainbow(5))
title(main="Death Rates in Virginia (1940)[beside=T]", font.main=4) # 타이틀 설정
dev.off() # pdf 종료

# dotchart(점도표)
# 그래프 관련 정리 http://blog.naver.com/kjhnav/220831638477
help(dotchart)
dotchart(x, labels = NULL, groups = NULL, gdata = NULL,
         cex = par("cex"), pt.cex = cex,
         pch = 21, gpch = 21, bg = par("bg"),
         color = par("fg"), gcolor = par("fg"), lcolor = "gray",
         xlim = range(x[is.finite(x)]),
         main = NULL, xlab = NULL, ylab = NULL, ...)
# x : 차트가 그려질 data
# labels : 점에 대한 설명문
# cex : 점의 확대
# pch : 점 모양
# color : 점 색상
# lcolor : 선 생상
# main : 차트 제목
# xlab, ylab : x,y축 이름

# 분기별 매출현황 dotchart 시각화
postscriptFonts()
pdf.options(family="Korea1")
pdf("C:/R_Studio/Rscript/chapter/chapter05/dot_pie.pdf")

chart_data
names(chart_data)
par(mfrow=c(1,1)) # 1행 1열 그래프 보기(한화면에 1개)
dotchart(chart_data, col=c("blue","red"), lcol="1", pch=1:2, labels=names(chart_data),
         xlab="매출액", main="2014, 2015년도 분기별 매출액 현황[dotchart]", cex=1.2)

# piechart 시각화
help(pie)
pie(x, labels = names(x), edges = 200, radius = 0.8,
    clockwise = FALSE, init.angle = if(clockwise) 90 else 0,
    density = NULL, angle = 45, col = NULL, border = NULL,
    lty = NULL, main = NULL, ...)
# x : 차트가 그려질 데이터
# labels : 조각에 대한 설명문
# col : 색상
# border : 테두리색
# lty : 선타입
# main : 제목

# 분기별 매출현황 시각화
pie(chart_data, labels=names(chart_data), col=rainbow(8), cex=1.0)
title("2014~2015년도 분기별 매출현황[piechart]")
dev.off()

# 연속변수 시각화
# 연속변수 : 시간, 길이 등 연속성을 가진 변수(boxplot, hist, scatterplot)
pdf("C:/R_Studio/Rscript/chapter/chapter05/boxplot.pdf")
help(boxplot)
summary(VADeaths)

boxplot(VADeaths, range=0,
        main="Death Rates in Virginia (1940)[boxplot default]") 
# range=0 : 최소값과 최대값을 점선으로 연결

boxplot(VADeaths, notch=T, 
        main="Death Rates in Virginia (1940)[boxplot notch=T]")
# notch=T : 중위수 비교시 사용(허리선)
mean(VADeaths) # 30.92
abline(h=30.92, lty=3, col="red")
help(abline)
dev.off()

# hist(히스토그램) 시각화
# 측정값의 범위(구간)을 x축, 범위에 속하는 측정값의 빈도수를 y축
# iris 데이터 셋 가져오기
data(iris)
help(iris)
head(iris)
str(iris) # 변수 5개, 관측치 150개
names(iris) # iris 변수명 : Sepal(꽃받침), Petal(꽃잎), Species(꽃의 종)
mode(iris); class(iris) # list, data.frame
levels(iris$Species) # 인자수 확인 : 3개

# iris의 꽃받침 길이 hist 시각화
par(mfrow=c(1,1))
pdf("C:/R_Studio/Rscript/chapter/chapter05/hist.pdf")
range(iris$Sepal.Length) # 꽃받침 길이 범위 : 4.3~7.9
hist(iris$Sepal.Length, xlab="iris$Sepal.Length", xlim=c(4.3,7.9), col="magenta",
     main="Histogram of iris$Sepal.Length [frequency=T]")
summary(iris$Sepal.Length)

# iris의 꽃받침 넓이 hist 시각화
range(iris$Sepal.Width) # 2.0~4.4
hist(iris$Sepal.Width, xlab="iris$Sepal.Width", xlim=c(2.0,4.5), col="mistyrose",
     main="Histogram of iris$Sepal.Width [frequency=T]")
# iris의 꽃받침 넓이 확률밀도 hist 시각화
hist(iris$Sepal.Width, freq=F, xlab="iris$Sepal.Width", xlim=c(2.0,4.5),
     main="Histogram of iris$Sepal.Width [density, frequency=F]")
# 정규분포 곡선 추정
# 단계 1 : 히스토그램에 밀도를 기준으로 분포곡선 그리기
lines(density(iris$Sepal.Width), col="red")
# 단계 2 : 히스토그램에 정규분포 추정 곡선 추가
curve(dnorm(x, mean(iris$Sepal.Width), sd(iris$Sepal.Width)), col="blue", add=T)
legend(3.3, 1.2, c("density line","normal dist line"), col=c("red","blue"), lwd=1)
dev.off()

# 산점도 시각화
# 두 개 이상의 변수들 사이의 분포를 점으로 표시한 차트
# ex : x축 몸무게, y축 
help(runif) # runif(x, min, max)
price <- runif(10,1,100) # 1~100 사이의 난수 10개
price
# 단계 1 : 산점도 그리기
pdf("C:/R_Studio/Rscript/chapter/chapter05/plot1.pdf")
postscriptFonts()
pdf.options(family="Korea1deb")
plot(price, col="red", ylim=c(0,100))
# 단계 2 : 대각선 추가
par(new=T)
line_chart=1:100
# 대각선 추가 : axes=F, ann=F 속성으로 x, y 축의 눈금과 축 이름 제거
plot(line_chart,type="l", axes=F, ann=F)
# 단계 3 : 텍스트 추가
text(70,80,"대각선 추가", col="blue")

# type 속성으로 그리기
par(mfrow=c(2,2))
plot(price, type="l", main="plot, type=l") # 실선
plot(price, type="o", main="plot, type=o") # 데이터 원형 표시와 실선
plot(price, type="h", main="plot, type=h") # 직선(barplot)
plot(price, type="s", main="plot, type=s") # 꺽은선

# pch 속성으로 그리기
plot(price, type="o", pch=1, main="pch=1")
plot(price, type="o", pch=20, col="orange", main="pch=20, col=orange")
plot(price, type="o", pch=20, col="orange", lwd=3,main="pch=20, col=orange, lwd=3")
plot(price, type="o", pch=20, col="orange", cex=1.5,
     main="pch=20, col=orange, cex=1.5")
dev.off()

# 시계열 자료
data("WWWusage")
str(WWWusage)
class(WWWusage); mode(WWWusage) # ts, numeric
plot.ts(WWWusage)

# 중첨자료 시각화
# 중복된 자료의 수 만큼 점의 크기 확대하기
# 단계 1 : x, y vector 만들기
x <- c(1,2,3,4,4,1,2,3,7,3,3,7,7,8,10)
x
y <- rep(2,15)
y
# 단계 2 : x, y vector를 table화
table(x,y) # (1,2) : 데이터 2개, (2,2) : 데이터 2개, (3,2) : 데이터 4개 ....
mode(table(x,y)); class(table(x,y)) # numeric, table
# 단계 3 : 산점도 그리기
par(mfrow=c(1,1))
plot(x,y) # 중복되어도 점이 하나 동일한 크기로 나옴
# 단계 4 : data.frame 생성
xy_df <- as.data.frame(table(x,y))
xy_df 
mode(xy_df); class(xy_df) # list, data.frame : 빈도수도 나옴(freq)
# 단계 5 : 좌표에 중복된 수 만큼 점 크기 확대
pdf("C:/R_Studio/Rscript/chapter/chapter05/overlap_plot.pdf")
plot(x,y, pch=20, col="blue", cex=1*xy_df$Freq, xlab="vector x's elements",
     ylab="vector y's elements", main="plot[cex=1*xy_df$Freq, pch=1]")
dev.off()
# galton 데이터 셋 대상 중복 자료 시각화
# 단계 1 : galton 데이터 셋 가져오기
require(psych)
data("galton")
head(galton)
str(galton) # 2개 변수, 928개 관측치
mode(galton); class(galton) # list, data.frame

# 단계 2 : galton 데이터 셋 table화
galton_tb <- table(galton$parent, galton$child) # x,y 별 빈도수 확인
mode(galton_tb); class(galton_tb) # numeric, table
str(galton_tb) # 11행, 14열

# 단계 3 : galton table을 data.frame화
galton_df <- data.frame(galton_tb)
galton_df
names(galton_df) <- c("parent", "child", "freq")
str(galton_df) # 3개 변수(freq 추가), 154관측치
mode(galton_df); class(galton_df) # list, data.frame
head(galton_df)

# data.frame -> vector -> numeric -> 가중치 적용
# vector화를 거치지 않으면 인데스 순이 나옴
parent <- as.numeric(as.vector(galton_df$parent))
head(parent); mode(parent); class(parent)
range(parent) # 64~73
child <- as.numeric(as.vector(galton_df$child))
head(child); mode(child); class(child)
range(child) # 61.7~73.7
# 단계 4 : plot 그리기
pdf("C:/R_Studio/Rscript/chapter/chapter05/galton_plot.pdf")
plot(child~parent, pch=21, bg="green", cex=0.25*galton_df$freq, col="blue",
     xlim=c(64,73), ylim=c(61.7,73.7), main="Galton's Mid parent child height's ScatterPlot")

# galton 상관분석
install.packages("UsingR")
require(UsingR)
sink("galton_cortest.txt")
cor.test(galton$parent, galton$child)
sink()
# p-value < 2.2e-16로 parent, child 두 변수는 매우 유의한 상관관계를 가지고 있다.
# 상관계수는 0.4587로 약한 양의 상관관계를 가진다.

# 회귀식
sink("galton_RegressionAnalysis.txt")
model =lm(child ~ parent, data=galton)
# y = 23.9415+0.6463x
model
# 회귀분석
summary(model)
# ① Residual
# 예측하고자 하는 변수의 실제 값과 회귀분석으로 얻어진 값 사이의 차이에는
# 표준오차로 인하여 차이가 발생하며 이를 잔차(residual)이라 한다

# ② Significance stars
# 계산된 p값에 따라 표시되는 별표의 수는 중요도의 수준을 나타내며, 
# ***는 높은 중요도, *는 낮은 중요도를 의미한다
# 위의 보기에서 ***가 의미하는 것은 부모의 신장과 자녀의 신장과의 관계를
# 서로 영향을 끼치지 않음을 의미하는 것이다.

# ③ Estimated coefficient
# 회귀분석에 의하여 산출된 기울기 값이다.

# ④ Standard error of the coefficient estimate
# coefficient 추정치의 변동성을 측정한다

# ⑤ t-value of the coefficient estimate
# 변수에 대한 coefficient가 해당 모델에 대하여 의미가 있는지 여부를 측정하며 이 값 자체는
# 사용하지 않으나 p값과 유의 수준을 계산하는데 사용한다

# ⑥ Variable p-value
# 유의수준으로 p값이 작을수록 신뢰구간에 들어간다
 
# ⑦ Significance legend
# 변수 옆에 구둣점이 많을수록 바람직 하다. 
# 공백은 나쁨, 점은 꽤 좋음, 별은 좋음, 복수의 별은 아주 좋음을 의미한다
# 
# ⑧ Residual Std error / Degrees of freedom 
# Residual Std error는 잔차의 표준편차이며, 자유도 (degree of freedom)은 샘플에 포함된
# 관측치의 개수와 모델에 사용된 변수갯수와의 차이이다
# 
# ⑨ R – squared
# 모델에 의하여 해석되는 예측의 변동량으로, 모델의 적합성을 평가하는 척도로도 사용된다.
# 1이 최고치이므로 1에 가까운 값이 바람직하다.
# 
# ⑩ F-statistics & resulting p-value
# 모델에서 F-test를 수행한다. 해당 모델의 변수를 취하고, 더 적은 수의 매개변수를 가진 모델과
# 비교한다. 이론적으로 매개변수가 많은 쪽이 더 잘 맞아야 하며, 더 많은 매개변수를 가진 모델이
# 더 적은 수의 매개변수를 가진 모델보다 잘 수행하지 않으면 
# F-test는 더 높은 p-value를 갖게 된다. 반면에 매개변수가 더 많은 모델이
# 매개변수가 적은 모델보다 낮다면 더 낮은 p-value를 갖게 된다.
sink()
plot(model)
dev.off()

# 변수 간의 비교 시각화
# 4개의 변수의 상호비교
attributes(iris) # iris 데이터 셋 확인
str(iris) #5개 변수, 150개 관측치
mode(iris); class(iris) # list, data.frame
head(iris)
help(pairs)
# 산점도 matrix
postscriptFonts()
pdf.options(family="Korea1deb")
pdf("C:/R_Studio/Rscript/chapter/chapter05/iris_pairs.pdf")
pairs(iris[,1:4], main="iris의 sepal~petal 비교")
# virginica 종의 4개변수 상호 비교
View(iris[iris$Species=='virginica', 1:5])
pairs(iris[iris$Species=='virginica', 1:4], main="virginica 종의 4개변수 상호 비교")
# setosa 종의 4개변수 상호 비교
View(iris[iris$Species=='setosa', 1:5])
pairs(iris[iris$Species=='setosa', 1:4], main="setosa 종의 4개변수 상호 비교")
dev.off()

# 3차원 산점도 시각화
# 단계 1 : 패키지 설치 및 로딩
install.packages("scatterplot3d")
require(scatterplot3d)

# 단계 2 : 꽃의 종류별 분류(Factor의 levels 보기)
levels(iris$Species) # "setosa" "versicolor" "virginica" 
iris_setosa <- iris[iris$Species=='setosa',]
iris_versicolor <- iris[iris$Species=='versicolor',]
iris_virginica <- iris[iris$Species=='virginica',]
# 단계 3 : 3차원 틀(Frame) 생성
# 형식 : scatterplot3d(밑변 컬럼명, 오른쪽변 컬럼명, 왼쪽변 컬럼명, type)
pdf("C:/R_Studio/Rscript/chapter/chapter05/iris_scatterplot3d.pdf")
iris_3d <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type="n")
# type="n" : 기본 산점도를 표시하지 않음

# 단계 4 : 3차원 3점도 시각화
iris_3d$points3d(iris_setosa$Petal.Length, iris_setosa$Sepal.Length, iris_setosa$Sepal.Width,
                 bg="orange", pch=21)
iris_3d$points3d(iris_versicolor$Petal.Length, iris_versicolor$Sepal.Length,
                 iris_versicolor$Sepal.Width, pch=23, bg="blue")
iris_3d$points3d(iris_virginica$Petal.Length, iris_virginica$Sepal.Length,
                 iris_virginica$Sepal.Width, pch=25, bg="green")
legend(iris_3d$xyz.convert(4,3,5.5),c("setosa","versicolor","virginica"),fill=c("orange","blue","green"))
title(main="iris의 setosa, versicolor, virginica 종의 꽃잎길이, 
꽃받침 넓이와 길이에 대한 3차원 산점도\n[scatterplot3d]")
dev.off()
