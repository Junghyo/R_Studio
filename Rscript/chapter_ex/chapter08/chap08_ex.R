# 8장 연습문제

# 1. 다음 조건에 맞게 quakes 데이터 셋의 수심(depth)과 리히터규모(mag)가 동일한 패널에 지진의
# 발생지를 산점도로 시각화 하시오
# 1-1. 수심 3개 영역으로 범주화
# 1-2. 리히터규모 2개 영역으로 범주화
# 1-3. 수심과 리히터규모가 3행 2열 구조의 패널로 산점도 그래프 그리기
# 1-4. lattice package의 equal.count()와 xyplot() 이용
library(lattice)
head(quakes)
depth_g <- equal.count(quakes$depth, number=3, overlap=0)
mag_g <- equal.count(quakes$mag, number=2, overlap=0)
xyplot(lat~long | depth_g*mag_g, data=quakes, col=c("red","blue"), layout=c(2,3))

# 2. latticeExtra package에서 제공하는 SeatacWeather 데이터 셋에서 월 별로 최저기온과
# 최고기온을 선 그래프로 플로팅하시오.
# 2-1. lattcie package의 xyplot() 이용
# 2-2. 선 그래프 type="l"
library(latticeExtra)
head(SeatacWeather)
xyplot(min.temp+max.temp~day | month, data=SeatacWeather, type="l")
help(filter)

# 3. diamonds 데이터 셋을 대상으로 x축에 carat변수, y축에 price변수를 지정하고, clarity변수를
# 선 색으로 지정하여 미적 요소 맵핑 객체를 생성한 후, 산점도 그래프 주변에 부드러운 곡선이
# 추가되도록 레이아웃을 추가하시오.
head(diamonds)
library(ggplot2)
p <- ggplot(diamonds, aes(carat, price, col=clarity))
p +geom_point()+geom_smooth(method="gam")
qplot(carat, price, data=diamonds, geom=c("point", "smooth"), col=clarity)

# 4. roadmap 지도 유형으로 서울지역 주요 대학교에 marker를 표시하시오
# 4-1. get_googlemap() 이용
# 4-2. 데이터 셋 Part-II, university.csv
# 4-3. 지도 이미지 저장 univ.png
univ <- read.csv(file.choose(), header=T)
library(maps)
library(mapproj)
library(ggmap)
seoul <- geocode("seoul")
seoul <- as.numeric(seoul)
seoul
# 학교 좌표로 data.frame 만들기
long <- univ$LON
lat <- univ$LAT
df <- data.frame(x=jitter(long), y=jitter(lat))
# 지도 정보 생성
map <- get_googlemap("seoul", zoom=11, markers=df)
# 그리기
ggmap(map, extent="device")

# 5. 각 지역별 총인구수를 roadmap 타입으로 시각화하시오.
# 5-1. 지도중심지역 Jeonju, zoom=7
# 5-2. 지역명으로 text 표시
# 데이터셋 Part-II, population201506.csv
pop <- read.csv(file.choose(), header=T)
map <- get_map("Jeonju", zoom=7, maptype="roadmap")
map1 <- ggmap(map)
map2 <- map1 + geom_point(aes(pop$LON, pop$LAT, col=pop$세대수, size=pop$세대수 ), data=pop)
map2 + geom_text(aes(pop$LON+0.01, pop$LAT+0.18, label=pop$지역명), data=pop, size=3)
