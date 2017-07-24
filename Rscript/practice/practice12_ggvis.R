#------------------------------
# R version 3.4.1 (2017-06-30)
#
# @ Author: yoda
# @ Mon Jul 24 23:17:33 2017
# @ Asia/Seoul
#------------------------------

# package 설치
install.packages("ggvis")
library(ggvis)

# data set loading
head(mtcars)
str(mtcars)

# objects in the database can be accessed by simply giving their names.
# attach(mtcars) 이후 mtcars의 컬럼명을 사용하겠다.
attach(mtcars)

# draw plot
plot(wt~mpg)

# ggvis(~x축 컬럼명, ~y축 컬럼명)
# data %>% ggvis(~x, ~y) pipe line이 반드시 필요한듯

# 1. points
mtcars %>%
  ggvis(~mpg,~wt) %>%
  layer_points()
# Guessing layer_points() : layer를 명시하지 않을 경우 default

# 2. lines
mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_lines()

# 3. bars (p12_ggvis1)
mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_bars()

# 4. smooths
mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_smooths()

# points + smooths
mtcars %>%
  ggvis(~mpg, ~wt, fill:="red") %>%
  layer_points() %>%
  layer_smooths()

# fill:="red" 변수가 오면 = 을 붙여도 되나 색상일 경우 : 을 붙여야함 

# points + smooths (add: cyl별 points color 다르게) (p12_ggvis2)
mtcars %>%
  ggvis(~mpg, ~wt, fill = ~cyl) %>%
  layer_points() %>%
  layer_smooths()
# cyl를 연속형으로 인식해서 label이 저런 형식으로 나옴'

# cyl 변수 factor 설정
cyl_f <- factor(mtcars$cyl)

# draw ggvis again(fill = ~cyl_f)
mtcars %>%
  ggvis(~mpg, ~wt, fill = ~cyl_f) %>%
  layer_points() %>%
  layer_smooths()

# xlim, ylim(x, y의 범위) 좀 더 세밀하게 설정(p12_ggvis3)
mtcars %>%
  ggvis(~mpg, ~wt, fill = ~cyl_f) %>%
  layer_points() %>%
  layer_smooths() %>%
  add_axis("x", title="MPG", values=c(10:35)) %>%
  add_axis("y", title="WT", subdivide=4)
# subdivide : 눈금 추가
# vlaues : 눈금 추가 및 눈금의 계측량 추가
