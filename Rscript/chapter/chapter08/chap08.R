# 고급시각화 도구
# 주요 package : graphics, lattice, ggplot2, ggmap 등
# graphics : barplot, pie, dotchart(이산변수) plot, hist, boxplot(연속변수)
# lattice : 서로 상관있는 확률적 반응 변수의 시각화
# ggplot2 : 기하학적 객체들(점, 선, 막대 등)에 미적 특성(크기, 색상)을 적용
# ggmap : 지도를 기반을 위치, 영역, 시간과 공간에 따른 차이 및 변화

# 격자형 기법 시각화
# lattice package 주요 함수
#     함수                      기능                                  graphics 함수 비교
# histogram()        연속형 변수 대상 히스토그램                        hist()함수 기능
# densityplot()      연속형 변수를 대상으로 밀도 그래프 그리기          없음(분포곡선 제공)
# barchart()         x, y축 적용 막대 그래프                            barplot()
# dotplot()          x, y축 적용 점 그래프                              dotchart()
# xyplot()           x, y축 적용 교차 그래프                            plot()
# equal.count()      데이터 셋을 지정한 영역만큼 범주화                 없음(카운터 제공)
# coplot()           조건 변수 조작으로 조건 그래프 그리기              없음(조건변수 조작)
# cloud()            3차원 산점도 그래프 그리기                         없음(3차원 제공)

# 단계 1 : package 설치
library(lattice)
# 단계 2 : 실습파일 가져오기
install.packages("mlmRev")
library(mlmRev)
data("Chem97")
str(Chem97) # 8개 변수, 31022 관측치
mode(Chem97); class(Chem97) # list, data.frame

# 히스토그램
# histogram(~x축 컬럼 | 조건, data=data)
pdf("C:/R_Studio/Rscript/chapter/chapter08/chem97_histogram.pdf")
histogram(Chem97$gcsescore, main="lattice Histogram[ histgram( ) ]")
hist(Chem97$gcsescore, main="graphics hist[ hist( ) ]")

# score를 조건변수로 지정하여 histogram 그리기
histogram(~Chem97$gcsescore | Chem97$score,
          main="histogram ~Chem97$gcsescore | Chem97$score")
histogram(~Chem97$gcsescore | factor(Chem97$score),
          main="histogram ~Chem97$gcsescore | factor(Chem97$score)")
dev.off()

# 밀도 그래프
# densityplot(~x축 컬럼 | 조건, data=data, groups=변수)
# 성별 변수를 그룹으로 GCES 점수를 score 단위로 밀도 그래프 그리기
pdf("C:/R_Studio/Rscript/chapter/chapter08/chem97_densityplot.pdf")
densityplot(~gcsescore | factor(score), data=Chem97, groups=gender, plot.points=T, 
            auto.key=T,
            main="densityplot [~gcsescore | factor(score), groups=gender, plot.points=T]")
densityplot(~gcsescore | factor(score), data=Chem97, groups=gender, plot.points=F, 
            auto.key=T,
            main="densityplot [~gcsescore | factor(score), groups=gender, plot.points=F]")
dev.off()
# plot.points=T : 밀도 점 표시 여부
# auto.key=T : 범례 표시 여부

# 막대 그래프
# barchart(y축컬럼~x축컬럼 | 조건, data=data, layout)
# 단계 1 : 데이터 셋 가져오기
data("VADeaths")
str(VADeaths) # 5행, 4열
mode(VADeaths); class(VADeaths) # numeric, matrix
barplot(VADeaths, beside=T, legend=rownames(VADeaths), col=1:5,
        main="barplot[beside=T, legend=rownames(VADeaths), col=1:5,]")

# 단계 2 : 데이터 형식 변경(matrix -> table)
vad_tb <- as.data.frame.table(VADeaths) # 넓은 형식에서 긴 형식으로 됨
str(vad_tb) # 3개 변수, 20개 관측치
mode(vad_tb); class(vad_tb) # list, data.frame
head(vad_tb)
names(vad_tb) <- c("age-group", "type", "Freq")

# 단계4 barchart 그리기
pdf("C:/R_Studio/Rscript/chapter/chapter08/VADeaths_barchart.pdf")
barchart(`age-group`~Freq | type, data=vad_tb,
         main="barchart[`age-group`~Freq | type, data=vad_tb] ")
barchart(`age-group`~Freq | type, data=vad_tb, layout=c(1,4),
         main="barchart[`age-group`~Freq | type, data=vad_tb, layout=c(1,4)]")
barchart(`age-group`~Freq | type, data=vad_tb, layout=c(4,1),
         main="barchart[`age-group`~Freq | type, data=vad_tb, layout=c(4,1)]")
dev.off()

# 점 그래프
# dotchart(y축컬럼~x축컬럼 | 조건, data=data, layout)
# 단계 1 : layout이 없는 경우
pdf("C:/R_Studio/Rscript/chapter/chapter08/VADeaths_dotplot.pdf")
dotplot(`age-group`~Freq | type, data=vad_tb,
        main="dotplot[`age-group`~Freq | type, data=vad_tb]")

# 단계 2 : layout 속성을 적용한 경우
dotplot(`age-group`~Freq | type, data=vad_tb, layout=c(4,1),
        main="dotplot[`age-group`~Freq | type, data=vad_tb, layout=c(4,1)]")

# 단계 3 : type을 그룹화하여 점을 선으로 연결하여 시각화
dotplot(`age-group`~Freq, groups=type, data=vad_tb, type="o",
        auto.key=list(lines=T, space="right", points=T),
        main="dotplot[`age-group`~Freq, groups=type, data=vad_tb, type='o'/n
        auto.key=list(lines=T, space='right', points=T)]")
dev.off()

# 산점도(xyplot)
# xyplot(y축 컬럼~x축 컬럼 | 조건변수, data=data, layout)
# 단계 1 : 데이터 셋 가져오기
library(datasets)
str(airquality) # 6개 변수, 153개 관측치
mode(airquality); class(airquality) # list, data.frame

# 단계 2 : xyplot(Ozone~Wind)
pdf("C:/R_Studio/Rscript/chapter/chapter08/airquality_xyplot.pdf")
xyplot(Ozone~Wind, data=airquality,
       main="xyplot[Ozone~Wind]")

# 단계 3 : xyplot(Ozone~Wind | Month)
xyplot(Ozone~Wind | factor(Month), data=airquality,
       main="xyplot[Ozone~Wind | factor(Month)]")

# 단계 4 : xyplot(Ozone~Wind | Month, layout)
xyplot(Ozone~Wind | Month, data=airquality, layout=c(5,1),
       main="xyplot[Ozone~Wind | Month, data=airquality, layout=c(5,1)]")

# 단계 5 : Moth 변수를 factor로 변경하여 그리기
air_convert <- transform(airquality, Month=factor(Month))
xyplot(Ozone~Wind | Month, data=air_convert, layout=c(5,1),
       main="xyplot[Ozone~Wind | Month, data=air_convert, layout=c(5,1)]")
dev.off()  

# quakes 데이터 셋으로 산점도 그리기
head(quakes)
str(quakes) # 5개 변수, 1000개 관측치, data.frame
# lat(위도), long(경도), depth(수심), mag(리히터규모), stations(관측소)
# 단계 1 : 지진발생 진앙지(위도와 경도) 산점도
pdf("C:/R_Studio/Rscript/chapter/chapter08/quakes_xyplot.pdf")
pdf.options(family="Korea1deb")
xyplot(lat~long, data=quakes, pch=".",
       main="xyplot[lat~long, data=quakes, pch='.']")

# 단계 2 : 산점도 그래프를 변수에 저장
quakes_plot <- xyplot(lat~long, data=quakes, pch=".")
quakes_plot2 <- update(quakes_plot, main="1964년 이후 태평양에서 발생한 지진위치")
print(quakes_plot2)
dev.off()
# 수심별 산점도 그리기
# 단계 1 : depth 변수 범위 확인
range(quakes$depth)
summary(quakes$depth) # 40~680

# 단계 2 : depth 변수 리코딩하여 depth2 변수 생성
quakes$depth2[quakes$depth>=40 & quakes$depth<=150] <- "40~150"
quakes$depth2[quakes$depth>=151 & quakes$depth<=250] <- "151~250"
quakes$depth2[quakes$depth>=251 & quakes$depth<=350] <- "251~350"
quakes$depth2[quakes$depth>=351 & quakes$depth<=450] <- "351~450"
quakes$depth2[quakes$depth>=451 & quakes$depth<=550] <- "451~550"
quakes$depth2[quakes$depth>=551 & quakes$depth<=680] <- "551~680"

# 단계 3 : depth2 변수를 조건 변수로 산점도 그리기
str(quakes)
xyplot(lat~long | factor(depth2), data=quakes, pch="+", 
       main="xyplot[lat~long | factor(depth2), data=quakes]")
quakes_convert <- transform(quakes, depth2=factor(depth2))
xyplot(lat~long | depth2, data=quakes_convert)
dev.off()
# 동일한 패널에 2개의 변수 값 표현
# xyplot(y1축+y2축~x축 | 조건, data, type, layout)
pdf("C:/R_Studio/Rscript/chapter/chapter08/airquality_y2_xyplot.pdf")
str(airquality)
xyplot(Ozone+Solar.R~Wind | factor(Month), data=airquality, col=c("red", "blue"),
       layout=c(5,1), auto.key=list(points=T, space="right"),
       main="xyplot[Ozone+Solar.R~Wind | factor(Month), data=airquality, col=c('red', 'blue')]")
dev.off()

# 데이터 범주화
# depth를 리코딩으로 범주화를 시켰는데 equal.count()를 사용하면 쉽게 범주화 작업을
# 할 수 있다.
# equal.count(data, number=n, overlap=0)
num_group <- equal.count(1:150, number=4, overlap=0)
num_group # 1~150을 4개 영역으로 범주화(겹치지 않게)
pdf("C:/R_Studio/Rscript/chapter/chapter08/quakes_category_xyplot.pdf")
depth_group <- equal.count(quakes$depth, number=5, overlap=0) # depth 5개 영역으로 범주화
depth_group

# 범주화한 depth_group으로 xyplot 그리기

xyplot(lat~long | depth_group, data=quakes, ylab="latitude", col="red", pch="+",
       xlab="longtitude", main="xyplot[lat~long | depth_group, data=quakes]")

# 수심(depth)과 리히터규모(mag) 변수를 동시에 적용하여 산점도 그리기
mag_group <- equal.count(quakes$mag, number=2, overlap=0)
mag_group

# 단계 1 : mag_group변수 기준으로 xyplot 그리기
xyplot(lat~long | mag_group, data=quakes, xlab="longtitude", ylab="latitude",
       main="xyplot[lat~long | mag_group, data=quakes]")
# 단계 2 : 수심과 리히터규모를 동시에 표현
xyplot(lat~long | depth_group*mag_group, data=quakes, ylab="latitude", xlab="longtitude",
       col=c("red", "blue"), pch="+",
       main="xyplot[lat~long | depth_group*mag_group, data=quakes] : red(depth), blue(mag)")

# depth와 mag 이산형변수로 리코딩하여 xyplot 그리기
depth_group
quakes$depth3[quakes$depth>=39.5 & quakes$depth<=80.5] <- 'd1'
quakes$depth3[quakes$depth>=79.5 & quakes$depth<=186.5] <- 'd2'
quakes$depth3[quakes$depth>=185.5 & quakes$depth<=397.5] <- 'd3'
quakes$depth3[quakes$depth>=396.5 & quakes$depth<=562.5] <- 'd4'
quakes$depth3[quakes$depth>=562.5 & quakes$depth<=680.5] <- 'd5'
mag_group
quakes$mag2[quakes$mag>=3.95 & quakes$mag<=4.65] <- 'm1'
quakes$mag2[quakes$mag>=4.55 & quakes$mag<=6.45] <- 'm2'
quakes_convert2 <- transform(quakes, depth3=factor(depth3), mag2=factor(mag2))
xyplot(lat~long | depth3*mag2, data=quakes_convert2, col=c("red", "blue"), pch="*",
       xlab="longtitude", ylab="latitude",
       main="lat~long | depth3*mag2, data=quakes_convert2, col=c('red', 'blue')")
dev.off()

# 조건 그래프
# 조건 a에 의해 x에 대한 y 그래프를 그려준다.
# 조건으로 지정된 변수의 값을 일정한 구간으로 범주화하여 조건 그래프를 그린다.
# coplot(y축 컬럼~x축 컬럼 | 조건 컬럼, data)

# depth 조건으로 위도(lat), 경도(long)의 조건 그래프 그리기
pdf("C:/R_Studio/Rscript/chapter/chapter08/quakes_coplot.pdf")
coplot(lat~long | depth, data=quakes, row=2, number=6, overlap=0.5)
title(main=list("coplot[lat~long | depth, data=quakes, row=2, number=6, overlap=0.5]",
                cex=0.9))
# row=2 : 패널 행수
# number=6 : 조건 사이의 간격(depth)
# overlap=0.5 : 겹치는 구간(0.1~0.9 : 작을수록 조건 사이 간격이 적게 겹친다.)
# overlap : default 0.5
# 단계 1 : 조건의 구간 막대가 0.1 단위로 겹치게
coplot(lat~long | depth, data=quakes, overlap=0.1)
title(main=list("coplot[lat~long | depth, data=quakes, overlap=0.1]", cex=0.9))
# 단계 2 : 조건 구간을 5개로 지정, 1행 5열의 패널로 조건 그래프 작성
coplot(lat~long | depth, data=quakes, number=5, row=1)
title(main=list("coplot[lat~long | depth, data=quakes, number=5, row=1]", cex=0.9))
# 단계 3 : 패널 영역에 부드러운 곡선 추가
coplot(lat~long | depth, data=quakes, number=5, row=1, panel=panel.smooth)
title(main=list("coplot[lat~long | depth, data=quakes, number=5, row=1, panel=panel.smooth]",
                cex=0.9))
# 단계 4 : 패녈 영역과 조건 막대에 색상 적용
coplot(lat~long | depth, data=quakes, number=5, row=1, col="blue", bar.bg=c(num='green'))
title(main=list("coplot[lat~long | depth, data=quakes, number=5, row=1, col='blue', bar.bg=c(num='green')]",
                cex=0.9))
dev.off()
