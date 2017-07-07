samsung <- read.csv("http://www.google.com/finance/historical?q=KRX%3A005930&ei=0DVcWemEAY3-0wT647KABw&output=csv")
str(samsung)
View(samsung)
summary(samsung)
head(samsung, 15)
names(samsung) <- c("Date", "Open", "High", "Low", "Close", "Volume")
mode(samsung$Date)
str(samsung)
date <- samsung$date
barplot(samsung$High, col=rainbow(20), xlab="날짜", ylab="최고치")
install.packages("lattice")
library(lattice)
example("barplot")
example(plot)
plot(samsung)
# 특정 컬럼의 명만 바꾸기
# names(데이터)[names(데이터)=='변경대상컬럼명"] <- c("변경컬럼명")
plot(samsung$High~samsung$Date, data=samsung)
fit <- lm(samsung$High~samsung$Date)
fit <- lm(samsung$Date~samsung$High, data=samsung)
Sys.getlocale()
sam_kospi_15 <- head(samsung,15)
class(sam_kospi_15$Date)
Sys.setlocale(category="LC_ALL", locale="English_US")
Sys.getlocale()
sam_kospi_15$Date
mode(sam_kospi_15$Date)
Rdate <- strptime(as.character(sam_kospi_15$Date),"%d-%b-%y")
Rdate
class(Rdate)
mode(Rdate)
sam_kospi_15$Date <- Rdate
sam_kospi_15$Date
xyplot(High+Low ~ Date, type="l", data=sam_kospi_15)
par(mfrow=c(1,1))

install.packages("XML")
library(XML)
info.url <- "http://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"
info.df <- readHTMLTable(info.url, header=T, which=1, stringsAsFactors=F)
write.csv(info.df, "C:/Users/acorn/Documents/Rwork/output/infoprocess.csv", row.names=F)

infoData <- read.csv(file.choose(), header=T)
View(infoData)
str(infoData)
head(infoData[,-c(2,3)])
imf.df <- read.csv("http://www.imf.org/external/pubs/ft/gfsr/2015/02/c1/boxfigure1_1_1.csv")
imf.df
head(imf.df)
View(imf.df)
imf_df <-imf.df
imf_df <-imf_df[-c(1:8),c(1:8)]
View(imf_df)
names(imf_df) <- c("data", "<0", "0-10", "11-20", "20-50", "50-100", "100-200", ">200")
plot(imf_df)
str(imf_df)
imf_df$data
imf_df$`0-10`
imf_df$`0-10`
