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
legend(3.9, 1.2, c("density line","normal dist line"), col=c("red","blue"), lwd=1)

