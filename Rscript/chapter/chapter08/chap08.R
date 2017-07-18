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

# 3차원 산점도 그래프
# x,y,z 축을 적용하여 3차원 산점도 그래프 가능
# cloud(z축변수~y축변수*x축변수, data)
# lat(위도), long(경도), depth(깊이)를 이용하여 3차원 산점도 그리기
pdf.options(family="Korea1deb")
pdf("C:/R_Studio/Rscript/chapter/chapter08/quakes_cloud.pdf")
cloud(depth~lat*long, quakes, xlab="경도", ylab="위도", zlab="깊이",
      zlim=rev(range(quakes$depth)),
      main="cloud[depth~lat*long, quakes, xlab='경도', ylab='위도', zlab='깊이',
      zlim=rev(range(quakes$depth))]")
range(quakes$depth) # [1]  40 680
rev(range(quakes$depth)) # [1] 680  40

# 테두리와 회전 속성 추가하여 3차원 산점도 그리기
cloud(depth~lat*long, quakes, zlim=rev(range(quakes$depth)), panel.aspect=0.9, 
      screen=list(z=45, x=-25), xlab="경도", ylab="위도", zlab="깊이",
      main="cloud[depth~lat*long, quakes, zlim=rev(range(quakes$depth)), panel.aspect=0.9, 
      screen=list(z=45, x=-25)]")
# panel.aspect=0.9 : 테두리 사이즈(작을수록 커짐)
# screen=list(z=45, x=-25) : z, x축 회전
install.packages("scatterplot3d")
library(scatterplot3d)
scatterplot3d(quakes$lat, quakes$long, quakes$depth, xlab="경도", ylab="위도", zlab="깊이",
              main="scatterplot3d[quakes$lat, quakes$long, quakes$depth, xlab='경도', ylab='위도', zlab='깊이']")

help(scatterplot3d)
dev.off()

# 추가 격자형 기법 시각화
# latticeExtra package
# doubleYscale() : 두 개의 y축을 서로 다르게 지정하여 동일한 패널에 서로 다른 변수 값을
#                  나타낼 수 있다.(이중 y축 그래프)

#   ecdfplot()   : 누적분포함수의 조건을 격자구조의 패널에 누적그래프 형태로 그려진다

# horizonplot()  : 시간의 변화에 따라서 ㅏ료의 변화 과정을 볼 수 있는 시계열 그래프를
#                  그려준다.(시계열 그래프)

#   mapplot()    : 지도 정보에 지도 데이터를 바인딩하여 지도 그래프를 그려준다.

# 이중 y축 그래프(doubleYscale)
# latticeExtra package 설치
install.packages("latticeExtra")
library(latticeExtra)
# 데이터 불러오기(SeatacWeather from latticeExtra)
data("SeatacWeather")
head(SeatacWeather)
str(SeatacWeather) # 14개 변수, 90개 관측치, data.frame

# 단계 1 : y축에 강수량(precip), x축에 일(day), 조건에 월(month) 변수를 적용하여 
#          직선그래프(type=h)를 그린다.
pdf("C:/R_Studio/Rscript/chapter/chapter08/SeatacWeather_doubleYScale.pdf")
rain <- xyplot(precip~day | month, data=SeatacWeather, type="h",
               main="xyplot[precip~day | month, data=SeatacWeather, type='h']")
print(rain)
# 단계 2 : y축에 최저기온(min.temp)+최고기온(max.temp), x축에 일(day), 조건에 월(month)
#          변수를 적용하여 선그래프(type=l)를 그린다.
temp <- xyplot(min.temp+max.temp~day | month, data=SeatacWeather, type="l",
               main="xyplot[min.temp+max.temp~day | month, data=SeatacWeather, type='l']")
print(temp)

# 단계 3 : 기온 정보가 저장된 temp 변수와 강수량 정보가 저장된 rain 변수를 대상으로
#          doubleYscale() 를 사용하여 하나의 통합된 그래프를 그린다.
doubleYScale(temp, rain, style1=0, style2=3, add.ylab2 = T, text=c("min", "max", "rain"),
             columns=3,
main="dobleYScale[temp, rain, style1=0, style2=3, add.ylab2 = T, text=c('min', 'max', 'rain'),
             columns=3]")
# 왼쪽 y축 style : style1=0 ,  오른쪽 y축 style : style2=3 (색)
# 왼쪽 y축 이름 : min.temp+max.temp
# 오른쪽 y축 이름 : add.ylab2=T (오른쪽에 y축이름 표시)
# text : 그래프 상단에 범례 추가

# 단계 4 : 직전 그래프에 색상 추가
update(trellis.last.object(), par.settings=simpleTheme(col=c("green", "red", "blue")))
dev.off()

# 누적분포함수 그래프
# ecdfplot()
# 데이터 셋 불러오기 및 구조 확인
head(singer)
str(singer) # 2개 변수, 235개 관측치, data.frame
names(singer) # [1] "height"     "voice.part"
range(singer$height) # [1] 60 76
levels(singer$voice.part)
attributes(singer$voice.part)

# 단계 1 : 'Bass 2' 목소리 영역을 대상으로 서브 셋 작성
bass2 <- subset(singer, singer$voice.part=='Bass 2')
str(bass2) # 2개 변수, 26개 관측치
range(bass2$height) # [1] 66 75
table(bass2$height) # 키 빈도수
# bass 2의 키 72 출현 비율
max(table(bass2$height))/length(bass2$height) # [1] 0.2692308 : 26.9%

# 단계 2 : factor형 변수(voice.part)를 조건으로 height변수의 누적분포 구하기
# ecdfplot(~x축 컬럼 | 조건변수, data)
pdf("C:/R_Studio/Rscript/chapter/chapter08/singer_ecdfplot.pdf")
ecdfplot(~height | voice.part, data=singer,
         main="ecdfplot[~height | voice.part, data=singer]")
dev.off()

# 8.3.3 시계열 그래프
# 데이터 셋 구조보기
head(EuStockMarkets)
str(EuStockMarkets) # 1860행, 4열, Time-Series
View(head(EuStockMarkets))
mode(EuStockMarkets); class(EuStockMarkets) # numeric, mts/ts/matrix
attributes(EuStockMarkets)
summary(EuStockMarkets) # 주식별 기술통계량
# 시계열 그래프 그리기
# horizonplot(data, colorkey=T/F, orgin= 1~ , horizonscale=1~)
help(horizonplot)
pdf("C:/R_Studio/Rscript/chapter/chapter08/EuStockMarkets_horizonplot.pdf")
horizonplot(EuStockMarkets, colorkey=T, origin=4000, horizonscale=1000,
            main="horizonplot[EuStockMarkets, colorkey=T, origin=4000, horizonscale=1000]")
# colorkey=T : 범례
# origin=4000 : 중심위치
# horizonscale=1000 : 가로 범위(1000으로 제한)
dev.off()

# 8.3.4 지도 그래프
# mapplot() : 지도 정보와 지도 데이터를 하나로 묶어서 지도를 그려주는 함수
# 단계 1 : package 설치
install.packages("maps")
install.packages("mapproj")
library(maps) # map() 함수
library(mapproj) # projection 지원
# 단계 2 : 데이터 셋 불러오기
head(USCancerRates)
str(USCancerRates) # 8개 변수, 3041개 관측치
attributes(USCancerRates)

# map(database, plot, fill, projection)
# database : world 또는 usa 데이터베이스 사용 가능.
#            usa 데이터베이스는 usa, state, country 중 하나의 데이터베이스를 지정할 수 있다.

# plot=T/F : map()을 이용하여 지도를 그릴지 여부 지정. map()은 지도 데이터와 바인딩 되어서
#            그려지기 때문에 map()에 의해 만들어진 지도 정보는 플로팅 하지 않음(plot=F)

# fill=T/F : map()에 의해 생성된 지도 정보와 데이터가 바인딩 될 때, 바인딩 될 데이터에 의해
#            색이 채워지도록 하는 기능

# projection : 지도를 레이어에 투사하는 방법으로 "mercator", "tetra", "azequalarea" 등의 
#              방식을 적용가능

# map() 이용 지도 정보 만들기
map <- map("county", plot=F, fill=T, projection="mercator")
# mapplot() 으로 지도 그리기
# mapplot(y축 ~ x축, data, map)
head(USCancerRates)
rownames(USCancerRates)
pdf("C:/R_Studio/Rscript/chapter/chapter08/USCancerRates_mapplot.pdf")
mapplot(rownames(USCancerRates)~log(rate.male)+log(rate.female), data=USCancerRates, map)
dev.off()

# 8.4 기하학적 방법 시각화
# ggplot2 package
# qplot() : 기하학적 객체와 미적요소 매핑으로 스케일링
# ggplot() : 미적요소 매핑에 레이어 관련 함수를 추가하여 프롤팅, 미적요소 재사용
# ggsave() : 해상도를 저굥ㅇ하여 다양한 형식의 이미지 파일 저장

# qplot(x축~y축, data, facets, geom, stat, position, xlim, ylim, log, main, xlab, ylab, asp)

# package 설치 및 데이터 셋 가져오기
install.packages("ggplot2")
library(ggplot2)
data(mpg)
str(mpg) # 11개 변수, 234개 관측치
mode(mpg); class(mpg) # list, tbl_df/tbl/data.frame
head(mpg)
summary(mpg)

# 1개 변수 대상 qplot() 함수 적용
table(mpg$hwy)
pdf("C:/R_Studio/Rscript/chapter/chapter08/mpg_qplot.pdf")
qplot(hwy, data=mpg, main="qplot[hwy, data=mpg]")
# fill=drv : hwy 변수값에서 drv변수값 색 채우기
qplot(hwy, data=mpg, fill=drv,
      main="qplot[hwy, data=mpg, fill=drv]")
# binwidth=2 : 막대 폭 지정속성
qplot(hwy, data=mpg, fill=drv, binwidth=2,
      main="qplot[hwy, data=mpg, fill=drv, binwidth=2]")
# facets=.~drv : drv 변수값으로 컬럼단위와 행 단위로 패널 생성
qplot(hwy, data=mpg, fill=drv, binwidth=2, facets=.~drv,
      main="qplot[hwy, data=mpg, fill=drv, binwidth=2, facets=.~drv]")
qplot(hwy, data=mpg, fill=drv, binwidth=2, facets=drv~.,
      main="qplot[hwy, data=mpg, fill=drv, binwidth=2, facets=drv~.]")

# 두 개 변수 대상 qplot()
qplot(displ, hwy, data=mpg, main="qplot[displ, hwy, data=mpg]")
# qplot() : color 속성
qplot(displ, hwy, data=mpg, color=drv,
      main="qplot[displ, hwy, data=mpg, color=drv]")
# qplot() : color, facets 속성
qplot(displ, hwy, data=mpg, color=drv, facets=.~drv,
      main="qplot[displ, hwy, data=mpg, color=drv, facets=.~drv]")
dev.off()

# 미적요소맵핑
# 단계 1 : 데이터 셋 가져오기
head(mtcars)
str(mtcars) # 11개 변수, 32개 관측치
pdf("C:/R_Studio/Rscript/chapter/chapter08/mtcars_qplot.pdf")
# 단계 2-1 색상 적용
qplot(wt, mpg, data=mtcars, color=factor(carb),
      main="qplot[wt, mpg, data=mtcars, color=factor(carb)]")
# 단계 2-2 크기 적용
qplot(wt, mpg, data=mtcars, color=factor(carb), size=qsec,
      main="qplot[wt, mpg, data=mtcars, color=factor(carb), size=qsec]")
# 단계 2-3 모양 적용
qplot(wt, mpg, data=mtcars, color=factor(carb), size=qsec, shape=factor(cyl),
      main="qplot[wt, mpg, data=mtcars, color=factor(carb), size=qsec, shape=factor(cyl)]")
dev.off()

# qplot()의 geom 속성 이용
# 단계 1 : 데이터 셋 가져오기
head(diamonds)
str(diamonds) # 10개 변수, 53940개 관측치
mode(diamonds); class(diamonds) # list, tbl_df/tbl/data.frame

# 단계 2 : geom="bar" 속성 막대 그래프
# 레이아웃에 색 채우기
pdf("C:/R_Studio/Rscript/chapter/chapter08/diamonds_qplot_bar.pdf")
qplot(clarity, data=diamonds, fill=cut, geom="bar",
      main='qplot[clarity, data=diamonds, fill=cut, geom="bar"]')
# 테두리 색 적용
qplot(clarity, data=diamonds, color=cut, geom="bar",
      main='qplot[clarity, data=diamonds, color=cut, geom="bar"]')
dev.off()

# geom="smooth"
pdf("C:/R_Studio/Rscript/chapter/chapter08/mtcars_qplot_smooth.pdf")
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"),
      main='qplot[wt, mpg, data=mtcars, geom=c("point", "smooth")]')
# cyl 변수의 요인으로 색상 적용
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), color=factor(cyl),
      main='qplot[wt, mpg, data=mtcars, geom=c("point", "smooth"), color=factor(cyl)]')
dev.off()

# ggplot()
# aes(x축변수, y축변수, color=변수)
# ggplot() 그래프가 그려지는 절차
# 1. 미적요소 맵핑(aes) : x축, y축, color 속성
# 2. 통계적인 변환(stat) : 통계계산 작업
# 3. 기하객체 사용(geom) : 차트 유형
# 4. 위치 조정(position adjustment) : 채우기(fill), 스택(stack), 닷지(dodge)

# stat_bin() 함수 적용
pdf("C:/R_Studio/Rscript/chapter/chapter08/diamonds_ggplot_stat_bin.pdf")
p <- ggplot(diamonds, aes(price))
p+stat_bin(aes(fill=cut), geom="area")+ggtitle('ggplot[ggplot(diamonds, aes(price))+stat_bin(aes(fill=cut), geom="area")')
p+stat_bin(aes(color=cut, size=..density..), geom="point")+ggtitle('ggplot[ggplot(diamonds, aes(price))+stat_bin(aes(color=cut, size=..density..), geom="point")')
dev.off()

# 테마 적용
# 축(axis), 격차(grid), 레이블(lable)
# 단계 1 : 제목이 적용된 산점도 그래프
pdf("C:/R_Studio/Rscript/chapter/chapter08/diamonds_ggplot_geom_point.pdf")
p <- ggplot(diamonds, aes(carat, price, color=cut))
p <-p+geom_point()+ggtitle("ggplot(diamonds, aes(carat, price, color=cut))+geom_point()")
print(p)
dev.off()

# 지도 공간 방법 시각화
# ggmap package
# geocode : 거리주소, 장소 이름을 이용하여 이용 지도 정보(위도, 경도) 획득

# get_googlemap : 구글지도서비스API에 접근하여 정적 지도 다운로드 및 지도에 maker,
#                 자신이 원하는 zoom level과 센터를 지정하여 지도 정보 생성

# get_map : 지도 서비스 관련 서버에 관련된 질의어를 지능형으로 인식하여 지도 정보 생성

# get_navermap : 네이버지도서비스API 사용

# ggimage : ggplot2와 동등한 수준으로 지도 이미지 생성

# ggmap/ggmapplot : get_map()함수에 의해서 생성된 픽셀 객체를 지도 이미지로 시각화

# qmap : ggmap()함수와 get_map() 함수의 통합 기능

# qmplot : ggplot2 package의 qplot()과 동등한 수준으로 지도 이미지 시각화

# Google Static Maps API 이용
# get_googlemap(center, zoom, size, scale, format, maptype, language, sensor,
#               color, markers, path)

# center  : 지도중심지역(위도, 경도)
# zoom    : 확대비율
# size    : 지도 이미지 가로, 세로 픽셀
# scale   : 지도 크기 지정
# format  : 지도 유형("terrain", "satelite", "roadmap", "hybrid")
# color   : 지도 색상
# sensor  : 사용자의 위치를 판단하기 위한 센서 사용 여부 지정
# markers : 지도 위에 표시될 marker
# path    : 마커 연결 표시

# package 세팅
install.packages("ggmap")
library(ggplot2)
library(ggmap)

# 단계 1 : 지도 위치 정보 가져오기
gc <- geocode("seoul") # 서울 위치 정보
mode(gc); class(gc) # list, data.frame
center <- as.numeric(gc)
center
mode(center); class(center) # numeirc, numeric

# 단계 2 : 지도 정보 생성하기
map <- get_googlemap(center=center, language="ko-KR", color="bw", scale=2)

# 단계 3 : 지도 이미지 그리기
ggmap(map, extent="device")

# 지도 위에 marker 삽입하기
# 단계 1 : marker data.frame 생성
df <- round(data.frame(x=jitter(rep(-95.36, 25), amount=.3), 
                       y=jitter(rep(29.76, 25), amount=.3)), digits=2)
# 단계 2 : 지도 위에 marker 적용
map <- get_googlemap('houston', markers=df, path=df, scale=2)
# 단계 3 : 장치에서 허용한 크기로 지도 그리기
ggmap(map, extent="device")

# 종합지도 서비스 관련 API 이용
# get_map(location, zoom, scale, maptype, source, color, language, api_key)
# location : 지도 상의 지역명을 직접 입력
# maptype  : 지도유형("roadmap", "watercolor", "toner" 등)
# source   : 지도 서비스 관련 서버 지정("google", "osm", "stamen", "cloudmad")
# api_key : cloudmad 지도 서비스를 위한 API key

# roadmap 타입으로 지도 그리기
map <- get_map(location="london", zoom=14, maptype="roadmap")
ggmap(map)
# watercolor 타입
map <- get_map(location="paris", maptype="watercolor", zoom=8)
ggmap(map)

# 지도 이미지에 레이어 적용
# 서울지역 4년제 대학교 위치 표시
# 단계 1 : 데이터 셋 가져오기
univ <- read.csv(file.choose(), header=T) # Part-II, university.csv
head(univ)
# 단계 2 : 정적 지도 생성
seoul <- get_map(location="seoul", zoom=11, maptype="watercolor")
# 단계 3 : 지도 위에 point 추가
seoul_univ <-ggmap(seoul)+geom_point(data=univ, aes(x=LON, y=LAT, color=factor(학교명)),
                                     size=3)
# 단계 4 : 지도 위에 text 추가
seoul_univ + geom_text(
  data=univ, aes(x=LON+0.01, y=LAT+0.01, label=학교명), size=3)

ggsave("C:/R_Studio/Rscript/chapter/chapter08/univ1.png", width=10.24, height=7.68)
ggsave("C:/R_Studio/Rscript/chapter/chapter08/unive2.png", dpi=1000)

# 인구조사 데이터 표현하기
# 단계 1 : 데이터 셋 불러오기
pop <- read.csv(file.choose(), header=T) # Part-II, population201506.csv
head(pop)
# 단계 2 : 지도 정보 생성
map <- get_map(location="daegu", zoom=7, maptype="watercolor")
# 단계 3 : 지도에 point 추가
map2 <- ggmap(map)+geom_point(aes(x=LON, y=LAT, color=세대수, size=세대수), data=pop)

# 단계 4 : 지도에 text 추가
map3 <- map2 + geom_text(data=pop, aes(x=LON+0.01, y=LAT+0.18, label=지역명), size=3)
map3 + geom_density2d()
