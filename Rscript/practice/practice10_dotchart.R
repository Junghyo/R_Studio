x <- 1:10
y <- x-1

plot(y~x)
# plot은 x, y 모두 연속형 변수

dotchart(y~x)
# Error in dotchart(y ~ x) : 'x' must be a numeric vector or matrix
# dotchart는 이산형

plot(mtcars$mpg)

dotchart(mtcars$mpg, labels=rownames(mtcars), cex=0.7)
# cex 글자크기

# mpg 순으로 재배열
carmpg <- mtcars[order(mtcars$mpg), ]

# cyl factor화
carmpg$cyl <- factor(carmpg$cyl)

class(carmpg$cyl) # factor

unique(carmpg$cyl) # 8, 6, 4

# cyl별 색 지정
carmpg$color[carmpg$cyl == 4] <- "blue"
carmpg$color[carmpg$cyl == 6] <- "green"
carmpg$color[carmpg$cyl == 8] <- "red"

help(dotchart)
jpeg("C:/R_Studio/Rscript/practice/p6_dotchart.jpg")
dotchart(carmpg$mpg, labels=rownames(carmpg), cex=0.7, col=carmpg$color,
         groups=carmpg$cyl, xlab="mpg",
         main="dotchart[carmpg$mpg, labels=rownames(carmpg), cex=0.7, col=carmpg$color,
         groups=carmpg$cyl]")
# groups = 해당 변수별로 그룹을 나눔
dev.off()
